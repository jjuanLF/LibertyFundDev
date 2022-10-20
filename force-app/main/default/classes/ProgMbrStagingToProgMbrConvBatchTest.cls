@isTest
private class ProgMbrStagingToProgMbrConvBatchTest{
    @testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
        List<Contact> listConferees = TestDataFactory.getListConfereeContacts(200);
        List<Campaign> listConferences = TestDataFactory.getListCoreConferences(200);
        List<ProgramMemberStagingTable__c> listTestData = Test.loadData(ProgramMemberStagingTable__c.SObjectType, 'programMbrStagingTableTestData');
        for(Integer i = 0; i < listConferees.size(); i++){
            listTestData.get(i).Staging_Batch__c = batch.Id;
            listTestData.get(i).PID__c = listConferees.get(i).LFPID__c;
            listTestData.get(i).BudgID__c = listConferences.get(i).LFBudgId__c;
        }
        update listTestData;
    }

    @isTest
    static void batchClassPositiveTest(){
        Test.startTest();
        ProgMbrStagingToProgMbrConversionBatch batchClass = new ProgMbrStagingToProgMbrConversionBatch();
        batchClass.isTest = true;
        Id batchId = Database.executeBatch(batchClass);
        Test.stopTest();

        Sync_History__c updatedBatch = [SELECT Id, Total_Records_Converted__c,Total_Failed_Conversions__c FROM Sync_History__c WHERE Status__c = 'Uploaded' LIMIT 1][0];
        List<CampaignMember> listTargetRecs = [SELECT Id FROM CampaignMember];
        System.assertEquals(200, updatedBatch.Total_Records_Converted__c);
        System.assertEquals((updatedBatch.Total_Records_Converted__c - updatedBatch.Total_Failed_Conversions__c), listTargetRecs.size());
    }
}