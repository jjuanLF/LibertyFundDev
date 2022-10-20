public with sharing virtual class Test implements Database.Batchable<Sobject>, Database.Stateful {
    public Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>> mapSourceFieldToTargetList; //Contains field mappings to convert from source to target
    public Sync_History__c batch; //Staging records are queried by the related Staging_History__c (batch) record
    public Integer daysToQuery = 1; //Can be overridden from Execute Anonymous Apex by specifying this.daysToQuery value to retry batch older than one day
    public Boolean isTest = false; //If true, limits query to 200 & prevents chaining in final method
    public Integer stagingRecordCount = 0;
    public Integer exceptionCount = 0;
    public Boolean cannotExecute = FALSE;
    
    //UPDATE these instance variables when creating new batch class (1/3)
    public final String sourceObject = 'ConferenceCitationStagingTable__c';
    public final String targetObject = 'Conference_Citation__c';
    public final String nextBatchJobToRun = 'ProgMbrStagingToProgMbrConversionBatch';

    //UPDATE constructor name to match class name when creating new batch class (2/3)
    public Test(){
        this.mapSourceFieldToTargetList = StagingTableConversionUtility.queryIntegrationStagingTableFieldMappings(this.sourceObject);
        this.batch = this.batch == null ? StagingTableConversionUtility.queryCurrentBatchToConvert(this.daysToQuery) : this.batch;

        if(mapSourceFieldToTargetList.keySet().size() == 0 || this.batch == null){
            String className = String.valueOf(this).substring(0, String.valueOf(this).indexOf(':'));
            String missingKeyInfo = mapSourceFieldToTargetList.keySet().size() == 0 ? 'No field mappings returned from Integration_Staging_Table_Field_Mapping__mdt query. ' : '';
            missingKeyInfo += this.batch == null ? 'No batch value returned from Sync_History__c query.' : '';
            System.debug('Failed to initialize class ' + className + ': ' + missingKeyInfo);
            this.cannotExecute = TRUE;
        }else{
            this.batch.Total_Records_Converted__c = this.batch?.Total_Records_Converted__c == null ? 0 : this.batch.Total_Records_Converted__c;
            this.batch.Total_Failed_Conversions__c = this.batch?.Total_Failed_Conversions__c == null ? 0 : this.batch.Total_Failed_Conversions__c;
        }
    }

    //UPDATE external Id object/field names when creating new batch class (3/3)
    private Schema.DescribeFieldResult defineExternalIdField(){
        Schema.DescribeFieldResult dfr = Conference_Citation__c.External_ID__c.getDescribe();
        return dfr;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query;
        if(this.cannotExecute){
            query = 'SELECT Id FROM ' + this.sourceObject + ' WHERE Name = null';
        }else{
            String fieldList = String.join(new List<String>(mapSourceFieldToTargetList.keySet()), ', ');
            query = 'SELECT Id, ' + String.escapeSingleQuotes(fieldList) + ' FROM ' + this.sourceObject + ' WHERE Staging_Batch__c = \'';
            query += this.batch.Id + '\' WITH SECURITY_ENFORCED' + (this.isTest ? ' LIMIT 200' : '');
        }
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Sobject> scope){
        if(this.cannotExecute){return;}

        this.stagingRecordCount += scope.size();
        List<Exception__c> listExceptionsToInsert = new List<Exception__c>();

        //Generate a map of Source Object records in scope where key is the external Id used to match the source and target records
        Schema.DescribeFieldResult dfrExtId = this.defineExternalIdField();
        Map<String, Sobject> mapExtIdToSourceRecord = (Map<String, Sobject>)Type.forName('Map<String, ' + this.sourceObject + '>').newInstance();
        for(Sobject sourceRecord : scope){
            mapExtIdToSourceRecord.put((String) sourceRecord.get(dfrExtId.getName()), sourceRecord);
        }

        //Generate a list of Target Object records from the Source Object records in scope using field mappings in mapSourceFieldToTargetList
        Map<String, Sobject> mapExtIdToTargetRecord = (Map<String, Sobject>)Type.forName('Map<String, ' + this.targetObject + '>').newInstance();
        mapExtIdToTargetRecord = StagingTableConversionUtility.generateTargetRecordFromMapping(
            mapExtIdToSourceRecord, mapSourceFieldToTargetList, this.batch.Id);
        mapExtIdToTargetRecord = StagingTableConversionUtility.convertRefFieldExtIdToRecordIdOnTargetRecord(
            mapExtIdToSourceRecord, mapExtIdToTargetRecord, mapSourceFieldToTargetList, this.batch.Id);

        //Convert generic Sobject list to specific Target Object, then upsert records
        Schema.SObjectField extId = dfrExtId.getSObjectField();
        List<Sobject> listTargetRecsToUpsert = (List<Sobject>)Type.forName('List<' + this.targetObject + '>').newInstance();
        listTargetRecsToUpsert.addAll(mapExtIdToTargetRecord.values());
        List<Database.UpsertResult> listUpsertResults = Database.upsert(listTargetRecsToUpsert, extId, false);

        Map<Id, Database.UpsertResult> mapSourceRecIdToUpsertResult = new Map<Id, Database.UpsertResult>();
        for(Integer i = 0; i < listTargetRecsToUpsert.size(); i++){
            mapSourceRecIdToUpsertResult.put(
                (Id) mapExtIdToSourceRecord.get((String) listTargetRecsToUpsert.get(i).get(dfrExtId.getName())).get('Id'), 
                listUpsertResults.get(i));
        }
        listExceptionsToInsert.addAll(StagingTableConversionUtility.logFailedUpsertsAsExceptions(
            mapSourceRecIdToUpsertResult, this.sourceObject, this.batch.Id, this.targetObject + ' Upsert Failed'));

        //Insert the list of upsert exception records
        this.exceptionCount += listExceptionsToInsert.size();
        List<Database.SaveResult> listInsertResults = Database.insert(listExceptionsToInsert, false);
        for(Database.SaveResult result : listInsertResults){
            if(!result.isSuccess()){
                System.debug('Bulk exception record insert error: ' + result.getErrors());
            }
        }
    }

    public void finish(Database.BatchableContext bc){
        if(this.cannotExecute){return;}
        
        //Update batch with records processed & failed
		try{
            this.batch.Total_Records_Converted__c += this.stagingRecordCount;
            this.batch.Total_Failed_Conversions__c += this.exceptionCount;
            update this.batch;
        }catch(Exception ex){
            System.debug('Batch record count update failed: (' + ex.getTypeName() + ') ' + ex.getMessage() + '(' + ex.getLineNumber() + ')');
            StagingTableConversionUtility.logTryCatchExceptionsAsExceptions(ex, this.batch.Id);
        }
        
        //Instantiate next batch class in the chain
        if(String.isNotBlank(this.nextBatchJobToRun) && this.isTest == FALSE){
            Database.Batchable<Sobject> nextJob = (Database.Batchable<Sobject>) Type.forName(this.nextBatchJobToRun).newInstance();
            Database.executeBatch(nextJob);
        }
	}
}
