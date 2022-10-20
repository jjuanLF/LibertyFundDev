global with sharing class StagingTableConversionSchedule implements Schedulable {
    global Boolean isTest = false;
    global void execute(SchedulableContext ctx) {
        //Check whether a valid batch record exists before kicking off the staging batch classes
        //This class uses the 'default' value of 1 day for the LAST_N_DAYS criterion in the batch query
        Sync_History__c validateBatch = StagingTableConversionUtility.queryCurrentBatchToConvert(1);
        
        if(validateBatch != null){
            //Update batch status for tracking purposes
            try{
                validateBatch.Status__c = 'Conversion in Progress';
                update validateBatch;
            }catch(Exception ex){
                System.debug('Batch status update failed: (' + ex.getTypeName() + ') ' + ex.getMessage() + '(' + ex.getLineNumber() + ')');
                StagingTableConversionUtility.logTryCatchExceptionsAsExceptions(ex, validateBatch.Id);
            }

            //All other Staging conversion classes are daisy chained to each other from the finish method.
            AccountStagingToAccountConversionBatch initialBatch = new AccountStagingToAccountConversionBatch();
            if(this.isTest == true){initialBatch.isTest = true;}
            //Currently runs with default batch size of 200
            Database.executebatch(initialBatch);
        }
    }
}