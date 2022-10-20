@isTest
private class CitationStagingToCitConvBatchTest{
    @testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
        List<CitationStagingTable__c> listTestData = Test.loadData(CitationStagingTable__c.SObjectType, 'citationStagingTableTestData');
        for(CitationStagingTable__c td : listTestData){
            td.Staging_Batch__c = batch.Id;
        }
        update listTestData;
    }

    @isTest
    static void batchClassPositiveTest(){
        Test.startTest();
        CitationStagingToCitationConversionBatch batchClass = new CitationStagingToCitationConversionBatch();
        batchClass.isTest = true;
        Id batchId = Database.executeBatch(batchClass);
        Test.stopTest();

        Sync_History__c updatedBatch = [SELECT Id, Total_Records_Converted__c,Total_Failed_Conversions__c FROM Sync_History__c WHERE Status__c = 'Uploaded' LIMIT 1][0];
        List<Citation__c> listTargetRecs = [SELECT Id FROM Citation__c];
        System.assertEquals(200, updatedBatch.Total_Records_Converted__c);
        System.assertEquals((updatedBatch.Total_Records_Converted__c - updatedBatch.Total_Failed_Conversions__c), listTargetRecs.size());
    }
}