public with sharing class StagingTableConversionUtility {

    //Method to query CMT that stores field mapping between objects
    public static Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>> queryIntegrationStagingTableFieldMappings(String sourceObjectName){
        //Storing as a map allows multiple target fields to be mapped to the same source field
        Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>> mapSourceFieldToTargetList = new Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>>();

        for(Integration_Staging_Table_Field_Mapping__mdt mapping: 
            [SELECT Id, Source_Object__c, Source_Field__c, Target_Object__c, Target_Field__c, Query_Object__c, Query_Field__c, Truncation_Limit__c
                FROM Integration_Staging_Table_Field_Mapping__mdt
                WHERE Source_Object__c = :sourceObjectName
                WITH SECURITY_ENFORCED]){
            
                if(mapSourceFieldToTargetList.containsKey(mapping.Source_Field__c)){
                    mapSourceFieldToTargetList.get(mapping.Source_Field__c).add(mapping) ;
                }else{
                    mapSourceFieldToTargetList.put(mapping.Source_Field__c, new List<Integration_Staging_Table_Field_Mapping__mdt>{mapping});
                }
        }
        return mapSourceFieldToTargetList;
    }

    //Method to query Sync_History__c object used to group staging records into "batches" for processing
    public static Sync_History__c queryCurrentBatchToConvert(Integer lastNDays){
        Datetime queryFromDate = Datetime.now().addDays(lastNDays * -1);
        List<Sync_History__c> listBatches = [SELECT Id, CreatedDate, Status__c, Total_Records_Converted__c, Total_Failed_Conversions__c, End_Date_Time__c
                                                FROM Sync_History__c 
                                                WHERE Status__c IN ('Uploaded', 'Conversion in Progress') AND CreatedDate >= :queryFromDate 
                                                WITH SECURITY_ENFORCED
                                                ORDER BY CreatedDate DESC];
        Sync_History__c batchToRun;

        if(listBatches != null && listBatches.size() > 0){
            batchToRun = listBatches[0];
        }
        return batchToRun;
    }

    //Method to generate Target table records from mapping table
    public static Map<String, Sobject> generateTargetRecordFromMapping(
                                            Map<String, Sobject> mapExtIdToSourceRecord,
                                            Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>> mapSourceFieldToTargetList,
                                            Id batchId){
        String sourceObject = mapSourceFieldToTargetList.values()[0][0].Source_Object__c;
        String targetObject = mapSourceFieldToTargetList.values()[0][0].Target_Object__c;
        Map<String, Sobject> mapExtIdToTargetRecord = new Map<String, Sobject>();

        for(String sourceRecord : mapExtIdToSourceRecord.keySet()){
            Sobject targetRecord = (Sobject) Type.forName(targetObject).newInstance();
            //Note: This method currently overwrites any existing data in the target record (in the case of an update)
            for(String sourceField : mapSourceFieldToTargetList.keySet()){
                for(Integration_Staging_Table_Field_Mapping__mdt mapping : mapSourceFieldToTargetList.get(sourceField)){
                    if(String.isBlank(mapping.Query_Object__c) && mapExtIdToSourceRecord.get(sourceRecord).get(mapping.Source_Field__c) != null){
                            try{
                                if(mapping.Truncation_Limit__c != null){
                                    Integer charLimit = mapping.Truncation_Limit__c.intValue();
                                    String fieldValue = (String) mapExtIdToSourceRecord.get(sourceRecord).get(mapping.Source_Field__c);
                                    targetRecord.put(mapping.Target_Field__c, fieldValue.left(charLimit));
                                }else{
                                    targetRecord.put(mapping.Target_Field__c, mapExtIdToSourceRecord.get(sourceRecord).get(mapping.Source_Field__c));
                                }
                            }catch(Exception ex){
                                System.debug('Field assignment for ' + sourceField + ' on ' + sourceObject + ' records failed: (' + ex.getTypeName() + ') ' + ex.getMessage() + '(' + ex.getLineNumber() + ')');
                                StagingTableConversionUtility.logTryCatchExceptionsAsExceptions(ex, batchId);
                                Integer mdtIndex = mapSourceFieldToTargetList.get(sourceField).indexOf(mapping);
                                mapSourceFieldToTargetList.get(sourceField).remove(mdtIndex);
                            }
                        }
                }
            }
            mapExtIdToTargetRecord.put(sourceRecord, targetRecord);
        }
        return mapExtIdToTargetRecord;
    }

    //Method to convert external Id values in reference fields to Salesforce record Ids on target records
    public static Map<String, Sobject> convertRefFieldExtIdToRecordIdOnTargetRecord(
                                            Map<String, Sobject> mapExtIdToSourceRecord,
                                            Map<String, Sobject> mapExtIdToTargetRecord,
                                            Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>> mapSourceFieldToTargetList,
                                            Id batchId){
        for(String sourceField : mapSourceFieldToTargetList.keySet()){
            for(Integration_Staging_Table_Field_Mapping__mdt mapping : mapSourceFieldToTargetList.get(sourceField)){
                if(String.isNotBlank(mapping.Query_Object__c) && String.isNotBlank(mapping.Query_Field__c)){ 
                    Set<String> setRefExtIdValues = new Set<String>();
                    for(String sourceRecExtId : mapExtIdToSourceRecord.keySet()){
                        if(String.isNotBlank((String) mapExtIdToSourceRecord.get(sourceRecExtId).get(mapping.Source_Field__c))){
                            setRefExtIdValues.add(String.escapeSingleQuotes((String) mapExtIdToSourceRecord.get(sourceRecExtId).get(mapping.Source_Field__c)));
                        }
                    }
                    if(setRefExtIdValues.size() == 0){continue;}
                    String formattedExtIdValues = String.join(new List<String>(setRefExtIdValues), '\',\'');
                    String query =  'SELECT Id, ' + mapping.Query_Field__c + 
                                    ' FROM ' + mapping.Query_Object__c + 
                                    ' WHERE ' + mapping.Query_Field__c + 
                                    ' IN (\'' + formattedExtIdValues + '\')' + 
                                    ' WITH SECURITY_ENFORCED';
                    List<Sobject> listQueryRecords = (List<Sobject>)Type.forName('List<' + mapping.Query_Object__c + '>').newInstance();
                    try{
                        listQueryRecords = Database.query(query);
                    }catch(Exception ex){
                        System.debug('Query for ' + mapping.Query_Object__c + ' records failed: (' + ex.getTypeName() + ') ' + ex.getMessage() + '(' + ex.getLineNumber() + ')');
                        StagingTableConversionUtility.logTryCatchExceptionsAsExceptions(ex, batchId);
                    }

                    Map<String, Id> mapExtIdToQueryRecId = new Map<String, Id>();
                    for(Sobject queryRecord : listQueryRecords){
                        mapExtIdToQueryRecId.put((String) queryRecord.get(mapping.Query_Field__c), (Id) queryRecord.get('Id'));
                    }
                    
                    for(String sourceRecExtId : mapExtIdToSourceRecord.keySet()){
                        mapExtIdToTargetRecord.get(sourceRecExtId).put(mapping.Target_Field__c, 
                            mapExtIdToQueryRecId.get((String) mapExtIdToSourceRecord.get(sourceRecExtId).get(mapping.Source_Field__c))
                        );
                    }
                }
            }
        }
        return mapExtIdToTargetRecord;
    }

    //Method to process exceptions and log for review
    public static List<Exception__c> logFailedUpsertsAsExceptions(
        Map<Id, Database.UpsertResult> mapSourceRecIdToUpsertResult, String sourceObject, Id batchId, String type ){

        Id recTypeId = Schema.SObjectType.Exception__c.getRecordTypeInfosByName().get('Legacy Integration').getRecordTypeId();
        List<Exception__c> listExceptionsToLog = new List<Exception__c>();
        
        for(Id sourceRecord : mapSourceRecIdToUpsertResult.keySet()){
            if(!mapSourceRecIdToUpsertResult.get(sourceRecord).isSuccess()){
                for(Database.Error error : mapSourceRecIdToUpsertResult.get(sourceRecord).getErrors()){
                    Exception__c exLog = new Exception__c();
                    exLog.Affected_Fields__c = String.join(error.getFields(), ', ');
                    exLog.Affected_Record_Id__c = mapSourceRecIdToUpsertResult.get(sourceRecord).getId();
                    exLog.Error_Message__c = error.getMessage();
                    exLog.RecordTypeId = recTypeId;
                    exLog.Status_Code__c = String.valueOf(error.getStatusCode());
                    exLog.Type__c = type;
                    exLog.Batch__c = batchId;
                    switch on sourceObject {
                        when 'AccountStagingTable__c' {
                            exLog.Account_Staging_Table__c = sourceRecord;
                        }
                        when 'CitationStagingTable__c' {
                            exLog.Citation_Staging_Table__c = sourceRecord;
                        }
                        when 'ConferenceCitationStagingTable__c' {
                            exLog.Conference_Citation_Staging_Table__c = sourceRecord;
                        }
                        when 'ContactStagingTable__c' {
                            exLog.Contact_Staging_Table__c = sourceRecord;
                        }
                        when 'EvaluationStagingTable__c' {
                            exLog.Evaluation_Staging_Table__c = sourceRecord;
                        }
                        when 'ProgramMemberStagingTable__c' {
                            exLog.Program_Member_Staging_Table__c = sourceRecord;
                        }
                        when 'ProgramStagingTable__c' {
                            exLog.Program_Staging_Table__c = sourceRecord;
                        }
                    }
                    listExceptionsToLog.add(exLog);
                }
            }
        }
        return listExceptionsToLog;
    }

    //Method to process try-catch block exceptions and log for review
    public static void logTryCatchExceptionsAsExceptions(Exception newExc, Id batchId){
        Id recTypeId = Schema.SObjectType.Exception__c.getRecordTypeInfosByName().get('Legacy Integration').getRecordTypeId();

        Exception__c exLog = new Exception__c();
        exLog.Error_Message__c = 'On line ' + String.valueOf(newExc.getLineNumber()) + ': ' + newExc.getMessage();
        exLog.RecordTypeId = recTypeId;
        exLog.Stack_Trace__c = newExc.getStackTraceString();
        exLog.Type__c = newExc.getTypeName();
        exLog.Batch__c = batchId;
        if(newExc.getTypeName() == 'DMLException'){
            exLog.Affected_Fields__c = String.join(newExc.getDmlFieldNames(0), ', ');
            exLog.Affected_Record_Id__c = newExc.getDmlId(0);
            exLog.Status_Code__c = String.valueOf(newExc.getDmlType(0));
            exLog.Error_Message__c += ' *** DML Message: ' + newExc.getDmlMessage(0);
        }

        try{
            insert exLog;
        }catch(Exception ex){
            System.debug('Insert try/catch exception failed: (' + ex.getTypeName() + ') ' + ex.getMessage() + '(' + ex.getLineNumber() + ')');
        }
    }
}