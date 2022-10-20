public with sharing class StagingTableConversionRecordCleanUp implements Database.Batchable<Sobject> {
    
    public Integer daysToQuery = 1; //Can be overridden from Execute Anonymous Apex by specifying this.daysToQuery value to retry batch older than one day
    
    public StagingTableConversionRecordCleanUp(){
        Sync_History__c validateBatch = StagingTableConversionUtility.queryCurrentBatchToConvert(this.daysToQuery);
        if(validateBatch != null){
            //Update batch status for tracking purposes
            try{
                validateBatch.Status__c = 'Converted';
                update validateBatch;
            }catch(Exception ex){
                System.debug('Batch status update failed: (' + ex.getTypeName() + ') ' + ex.getMessage() + '(' + ex.getLineNumber() + ')');
                StagingTableConversionUtility.logTryCatchExceptionsAsExceptions(ex, validateBatch.Id);
            }
        }
    }
    
	public Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, Status__c FROM Sync_History__c LIMIT 1'; //placeholder query
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Sobject> scope){
    }

    public void finish(Database.BatchableContext bc){
    }
    
    /*
    //converting logic to batch due to query row limitations
    public Integer daysOlderThan = 15; //As above can be overridden to update the age in number of days at which records should be deleted automatically
    
    private void deleteOldSyncHistoryRecords(){
        List<Sobject> listRecordsToDelete = new List<Sobject>();
        Set<String> objectsToQuery = new Set<String>();
        for(Integration_Staging_Table_Field_Mapping__mdt mapping: [SELECT Id, Source_Object__c FROM Integration_Staging_Table_Field_Mapping__mdt WITH SECURITY_ENFORCED]){
			objectsToQuery.add(mapping.Source_Object__c);
        }
        
        for(String obj : objectsToQuery){
            String query = 'SELECT Id FROM ' + obj + ' WHERE CreatedDate < LAST_N_DAYS:' + daysOlderThan + ' LIMIT 50000';
            Integer queryCount = Database.countQuery(query);
            while(queryCount > 0){
                listRecordsToDelete.addAll(Database.query(query));
                queryCount = Database.countQuery(query);
            }
            
        }
        
        System.debug('List to delete count: ' + listRecordsToDelete.size());
        
		try{
			Database.delete(listRecordsToDelete, false);
        }catch(Exception ex){
        	System.debug('Bulk record delete failed: (' + ex.getTypeName() + ') ' + ex.getMessage() + '(' + ex.getLineNumber() + ')');
        }
    }*/
}