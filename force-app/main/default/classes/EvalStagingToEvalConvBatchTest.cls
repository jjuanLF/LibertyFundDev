@isTest
private class EvalStagingToEvalConvBatchTest{
    @testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
        Contact con = TestDataFactory.getConfereeContact();
        Campaign prog = TestDataFactory.getCoreConference(true);
        List<EvaluationStagingTable__c> listTestData = Test.loadData(EvaluationStagingTable__c.SObjectType, 'evaluationStagingTableTestData');
        for(Integer i = 0; i < listTestData.size(); i++){
            listTestData.get(i).Staging_Batch__c = batch.Id;
            listTestData.get(i).PID__c = con.LFPID__c;
            listTestData.get(i).BudgID__c = prog.LFBudgId__c;
        }
        update listTestData;
    }

    @isTest
    static void batchClassPositiveTest(){
        Test.startTest();
        EvalStagingToEvaluationConversionBatch batchClass = new EvalStagingToEvaluationConversionBatch();
        batchClass.isTest = true;
        Id batchId = Database.executeBatch(batchClass);
        Test.stopTest();

        Sync_History__c updatedBatch = [SELECT Id, Total_Records_Converted__c,Total_Failed_Conversions__c FROM Sync_History__c WHERE Status__c = 'Uploaded' LIMIT 1][0];
        List<Evaluation__c> listTargetRecs = [SELECT Id FROM Evaluation__c];
        System.assertEquals(200, updatedBatch.Total_Records_Converted__c);
        System.assertEquals((updatedBatch.Total_Records_Converted__c - updatedBatch.Total_Failed_Conversions__c), listTargetRecs.size());
    }
}