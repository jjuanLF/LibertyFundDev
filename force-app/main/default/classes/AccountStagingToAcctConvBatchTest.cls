@isTest
private class AccountStagingToAcctConvBatchTest{
    @testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
        List<AccountStagingTable__c> listTestData = Test.loadData(AccountStagingTable__c.SObjectType, 'accountStagingTableTestData');
        for(AccountStagingTable__c td : listTestData){
            td.Staging_Batch__c = batch.Id;
        }
        update listTestData;
    }

    @isTest
    static void batchClassPositiveTest(){
        Test.startTest();
        AccountStagingToAccountConversionBatch batchClass = new AccountStagingToAccountConversionBatch();
        batchClass.isTest = true;
        Id batchId = Database.executeBatch(batchClass);
        Test.stopTest();

        Sync_History__c updatedBatch = [SELECT Id, Total_Records_Converted__c,Total_Failed_Conversions__c FROM Sync_History__c WHERE Status__c = 'Uploaded' LIMIT 1][0];
        List<Account> listTargetRecs = [SELECT Id FROM Account];
        System.assertEquals(200, updatedBatch.Total_Records_Converted__c);
        System.assertEquals((updatedBatch.Total_Records_Converted__c - updatedBatch.Total_Failed_Conversions__c), listTargetRecs.size());
    }
}