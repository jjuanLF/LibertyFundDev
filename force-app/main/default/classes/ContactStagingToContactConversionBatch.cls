public with sharing class ContactStagingToContactConversionBatch implements Database.Batchable<Sobject>, Database.Stateful {
    // DO NOT CLONE NEW STAGING BATCHES FROM THIS CLASS; IT HAS BEEN CUSTOMIZED FOR ADDITIONAL REQUIREMENTS

    public Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>> mapSourceFieldToTargetList; //Contains field mappings to convert from source to target
    public Sync_History__c batch; //Staging records are queried by the related Staging_History__c (batch) record
    public Integer daysToQuery = 1; //Can be overridden from Execute Anonymous Apex by specifying this.daysToQuery value to retry batch older than one day
    public Boolean isTest = false; //If true, limits query to 200 & prevents chaining in final method
    public Integer stagingRecordCount = 0;
    public Integer exceptionCount = 0;
    public Boolean cannotExecute = FALSE;
    public final String sourceObject = 'ContactStagingTable__c';
    public final String targetObject = 'Contact';
    public final String nextBatchJobToRun = 'ProgramStagingToProgramConversionBatch';

    public ContactStagingToContactConversionBatch(){
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

    private Schema.DescribeFieldResult defineExternalIdField(){
        Schema.DescribeFieldResult dfr = Contact.LFPID__c.getDescribe();
        return dfr;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query;
        if(this.cannotExecute){
            query = 'SELECT Id FROM ' + this.sourceObject + ' WHERE Name = null';
        }else{
            String fieldList = String.join(new List<String>(mapSourceFieldToTargetList.keySet()), ', ');
            query = 'SELECT Id, ' + String.escapeSingleQuotes(fieldList);
            //Contact Only - Must query additional fields on ContactStagingTable__c for Email Address processing
            query += ', Email01__c, Email02__c, Email03__c';
            query += ' FROM ' + this.sourceObject + ' WHERE Staging_Batch__c = \'';	
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

        //Contact only code block: Create Affiliation Accounts if not in Salesforce
        Set<Account> setAffilationAcctsToInsert = new Set<Account>();
        Id acctRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
        for(String targetRecord : mapExtIdToTargetRecord.keySet()){
            if(String.isBlank((String) mapExtIdToTargetRecord.get(targetRecord).get('AccountId')) &&
                String.isNotBlank((String) mapExtIdToSourceRecord.get(targetRecord).get('Affiliation_Name__c'))){
                    Account newAffiliation = new Account();
                    newAffiliation.RecordTypeId = acctRecTypeId;
                    newAffiliation.Name = (String) mapExtIdToSourceRecord.get(targetRecord).get('Affiliation_Name__c');
                    //Field created as a workaround since Name cannot be flagged as an externalId for use in Upsert
                    newAffiliation.Affiliation_Name__c = (String) mapExtIdToSourceRecord.get(targetRecord).get('Affiliation_Name__c');
                    setAffilationAcctsToInsert.add(newAffiliation);
                }
        }
        List<Account> listAffilationAcctsToInsert = new List<Account>(setAffilationAcctsToInsert);
        Schema.SObjectField acctExtId = Account.Affiliation_Name__c.getDescribe().getSObjectField();
        List<Database.UpsertResult> listAccountResults = Database.upsert(listAffilationAcctsToInsert, acctExtId, false);

        Map<String, Database.UpsertResult> mapAcctNameToInsertResult = new Map<String, Database.UpsertResult>();
        for(Integer i = 0; i < listAffilationAcctsToInsert.size(); i++){
            mapAcctNameToInsertResult.put((String) listAffilationAcctsToInsert.get(i).get('Name'), listAccountResults.get(i));
        }
        Map<Id, Database.UpsertResult> mapSourceRecIdToAcctInsertResult = new Map<Id, Database.UpsertResult>();
        for(String targetRecord : mapExtIdToTargetRecord.keySet()){
            if(String.isNotBlank((String) mapExtIdToSourceRecord.get(targetRecord).get('Affiliation_Name__c')) && 
                mapAcctNameToInsertResult.containsKey((String) mapExtIdToSourceRecord.get(targetRecord).get('Affiliation_Name__c'))){
                if(mapAcctNameToInsertResult.get((String) mapExtIdToSourceRecord.get(targetRecord).get('Affiliation_Name__c')).isSuccess()){
                    mapExtIdToTargetRecord.get(targetRecord).put(
                        'AccountId', 
                        mapAcctNameToInsertResult.get((String) mapExtIdToSourceRecord.get(targetRecord).get('Affiliation_Name__c')).getId());
                }else{
                    mapSourceRecIdToAcctInsertResult.put(
                        (Id) mapExtIdToSourceRecord.get(targetRecord).get('Id'), 
                        mapAcctNameToInsertResult.get((String) mapExtIdToSourceRecord.get(targetRecord).get('Affiliation_Name__c')));
                }
            }
        }
        listExceptionsToInsert.addAll(StagingTableConversionUtility.logFailedUpsertsAsExceptions(
            mapSourceRecIdToAcctInsertResult, this.sourceObject, this.batch.Id, 'Affiliation Account Insert Failed'));
        //End contact only

        //Generate a list of Target Object records from the Source Object records in scope using field mappings in mapSourceFieldToTargetList
        Schema.SObjectField extId = dfrExtId.getSObjectField();
        List<Sobject> listTargetRecsToUpsert = (List<Sobject>)Type.forName('List<' + this.targetObject + '>').newInstance();
        listTargetRecsToUpsert.addAll(mapExtIdToTargetRecord.values());
        List<Database.UpsertResult> listUpsertResults = Database.upsert(listTargetRecsToUpsert, extId, false);

        Map<Id, Database.UpsertResult> mapSourceRecIdToUpsertResult = new Map<Id, Database.UpsertResult>();
        Map<Id, ContactStagingTable__c> mapUpsertedContactIdToSourceRecord = new Map<Id, ContactStagingTable__c>(); //Contact only
        for(Integer i = 0; i < listTargetRecsToUpsert.size(); i++){
            mapSourceRecIdToUpsertResult.put(
                (Id) mapExtIdToSourceRecord.get((String) listTargetRecsToUpsert.get(i).get(dfrExtId.getName())).get('Id'), 
                listUpsertResults.get(i));
            //Contact only if block
            if(listUpsertResults.get(i).isSuccess()){
                mapUpsertedContactIdToSourceRecord.put(
                    listUpsertResults.get(i).getId(), 
                    (ContactStagingTable__c) mapExtIdToSourceRecord.get((String) listTargetRecsToUpsert.get(i).get(dfrExtId.getName())));
            }
        }
        listExceptionsToInsert.addAll(StagingTableConversionUtility.logFailedUpsertsAsExceptions(
            mapSourceRecIdToUpsertResult, this.sourceObject, this.batch.Id, this.targetObject + ' Upsert Failed'));

        //Contact only code block: Insert Email Address Records
        List<Email_Address__c> listEmailAddressesToInsert = this.generateEmailAddressListToUpsert(mapUpsertedContactIdToSourceRecord);
        Schema.SObjectField emailExtId = Email_Address__c.External_ID__c.getDescribe().getSObjectField();
        List<Database.UpsertResult> listResultsEmail = Database.upsert(listEmailAddressesToInsert, emailExtId, false);
        Map<Id, Database.UpsertResult> mapSourceRecIdToEmailUpsertResult = new Map<Id, Database.UpsertResult>();
        for(Integer i = 0; i < listEmailAddressesToInsert.size(); i++){
            String emailExtIdValue = ((String) listEmailAddressesToInsert.get(i).get('External_ID__c')).replaceFirst('[_][0][123]$','');
            mapSourceRecIdToEmailUpsertResult.put(
                (Id) mapExtIdToSourceRecord.get(emailExtIdValue).get('Id'), 
                listResultsEmail.get(i));
        }
        listExceptionsToInsert.addAll(StagingTableConversionUtility.logFailedUpsertsAsExceptions(
            mapSourceRecIdToEmailUpsertResult, this.sourceObject, this.batch.Id, 'Email Address Upsert Failed'));
        //End contact only

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

    //Contact only method
    private List<Email_Address__c> generateEmailAddressListToUpsert(Map<Id, ContactStagingTable__c> mapUpsertedContactIdToSourceRecord){
        //Requires map of Contact Id to ContactStagingTable__c because email01, email02, and email03 are not on the Contact record
        List<Email_Address__c> listEmailAddressesToInsert = new List<Email_Address__c>();

        for(Id contactId : mapUpsertedContactIdToSourceRecord.keySet()){
            String correspondenceEmail = (String) mapUpsertedContactIdToSourceRecord.get(contactId).get('Correspondence_Email__c');
            String publicEmail = (String) mapUpsertedContactIdToSourceRecord.get(contactId).get('Public_Email__c');
            String email01 = (String) mapUpsertedContactIdToSourceRecord.get(contactId).get('Email01__c');
            String email02 = (String) mapUpsertedContactIdToSourceRecord.get(contactId).get('Email02__c');
            String email03 = (String) mapUpsertedContactIdToSourceRecord.get(contactId).get('Email03__c');

            if(String.isNotBlank(email01)){
                Email_Address__c emailRec01 = new Email_Address__c();
                emailRec01.External_ID__c = mapUpsertedContactIdToSourceRecord.get(contactId).get('LFPID__c') + '_01';
                emailRec01.Contact__c = contactId;
                emailRec01.Email__c = email01;
                if(correspondenceEmail != null && email01.toLowerCase() == correspondenceEmail.toLowerCase()){
                    emailRec01.Correspondence_Email__c = TRUE;
                }else{
                    emailRec01.Correspondence_Email__c = FALSE;
                }
                if(publicEmail != null && email01.toLowerCase() == publicEmail.toLowerCase()){
                    emailRec01.Public_Email__c = TRUE;
                }else{
                    emailRec01.Public_Email__c = FALSE;
                }
                listEmailAddressesToInsert.add(emailRec01);
            }
            if(String.isNotBlank(email02)){
                Email_Address__c emailRec02 = new Email_Address__c();
                emailRec02.External_ID__c = mapUpsertedContactIdToSourceRecord.get(contactId).get('LFPID__c') + '_02';
                emailRec02.Contact__c = contactId;
                emailRec02.Email__c = email02;
                if(correspondenceEmail != null && email02.toLowerCase() == correspondenceEmail.toLowerCase()){
                    emailRec02.Correspondence_Email__c = TRUE;
                }else{
                    emailRec02.Correspondence_Email__c = FALSE;
                }
                if(publicEmail != null && email02.toLowerCase() == publicEmail.toLowerCase()){
                    emailRec02.Public_Email__c = TRUE;
                }else{
                    emailRec02.Public_Email__c = FALSE;
                }
                listEmailAddressesToInsert.add(emailRec02);
            }
            if(String.isNotBlank(email03)){
                Email_Address__c emailRec03 = new Email_Address__c();
                emailRec03.External_ID__c = mapUpsertedContactIdToSourceRecord.get(contactId).get('LFPID__c') + '_03';
                emailRec03.Contact__c = contactId;
                emailRec03.Email__c = email03;
                if(correspondenceEmail != null && email03.toLowerCase() == correspondenceEmail.toLowerCase()){
                    emailRec03.Correspondence_Email__c = TRUE;
                }else{
                    emailRec03.Correspondence_Email__c = FALSE;
                }
                if(publicEmail != null && email03.toLowerCase() == publicEmail.toLowerCase()){
                    emailRec03.Public_Email__c = TRUE;
                }else{
                    emailRec03.Public_Email__c = FALSE;
                }
                listEmailAddressesToInsert.add(emailRec03);
            }
        }
        return listEmailAddressesToInsert;
    }
}