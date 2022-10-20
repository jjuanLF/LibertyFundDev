@isTest
private class ConfCitStagingToConfCitConvBatchTest{
    @testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
        Campaign prog = TestDataFactory.getCoreConference(true);
        Citation__c cit = TestDataFactory.getCitation();
        List<ConferenceCitationStagingTable__c> listTestData = Test.loadData(ConferenceCitationStagingTable__c.SObjectType, 'confCitationStagingTableTestData');
        for(Integer i = 0; i < listTestData.size(); i++){
            listTestData.get(i).Staging_Batch__c = batch.Id;
            listTestData.get(i).BudgID__c = prog.LFBudgId__c;
            listTestData.get(i).PID__c = cit.BiblioId__c;
        }
        update listTestData;
    }

    @isTest
    static void batchClassPositiveTest(){
        Test.startTest();
        ConfCitStagingToConfCitConversionBatch batchClass = new ConfCitStagingToConfCitConversionBatch();
        batchClass.isTest = true;
        Id batchId = Database.executeBatch(batchClass);
        Test.stopTest();

        Sync_History__c updatedBatch = [SELECT Id, Total_Records_Converted__c,Total_Failed_Conversions__c FROM Sync_History__c WHERE Status__c = 'Uploaded' LIMIT 1][0];
        List<Conference_Citation__c> listTargetRecs = [SELECT Id FROM Conference_Citation__c];
        System.assertEquals(200, updatedBatch.Total_Records_Converted__c);
        System.assertEquals((updatedBatch.Total_Records_Converted__c - updatedBatch.Total_Failed_Conversions__c), listTargetRecs.size());
    }
}