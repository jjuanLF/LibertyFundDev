@isTest
private class ProgramStagingToProgConvBatchTest{
    @testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
        Contact fellow = TestDataFactory.getFellowContact();
        Account hotel = TestDataFactory.getVendorAccount();
        List<ProgramStagingTable__c> listTestData = Test.loadData(ProgramStagingTable__c.SObjectType, 'programStagingTableTestData');
        for(Integer i = 0; i < listTestData.size(); i++){
            listTestData.get(i).Staging_Batch__c = batch.Id;
            listTestData.get(i).Fellow__c = fellow.LFPID__c;
            listTestData.get(i).Hotel__c = hotel.LF_Vendor_ID__c;
        }
        update listTestData;
    }

    @isTest
    static void batchClassPositiveTest(){
        Test.startTest();
        ProgramStagingToProgramConversionBatch batchClass = new ProgramStagingToProgramConversionBatch();
        batchClass.isTest = true;
        Id batchId = Database.executeBatch(batchClass);
        Test.stopTest();

        Sync_History__c updatedBatch = [SELECT Id, Total_Records_Converted__c,Total_Failed_Conversions__c FROM Sync_History__c WHERE Status__c = 'Uploaded' LIMIT 1][0];
        List<Campaign> listTargetRecs = [SELECT Id FROM Campaign];
        System.assertEquals(200, updatedBatch.Total_Records_Converted__c);
        System.assertEquals((updatedBatch.Total_Records_Converted__c - updatedBatch.Total_Failed_Conversions__c), listTargetRecs.size());
    }
}