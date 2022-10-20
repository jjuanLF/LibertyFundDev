@isTest
private class ContactStagingToConConvBatchTest{
    @testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
        Campaign prog = TestDataFactory.getCoreConference(false); //Do not create Fellow contact to avoid impact to contact query in assertion
        List<ContactStagingTable__c> listTestData = Test.loadData(ContactStagingTable__c.SObjectType, 'contactStagingTableTestData');
        for(Integer i = 0; i < listTestData.size(); i++){
            listTestData.get(i).Staging_Batch__c = batch.Id;
            listTestData.get(i).First_Conference__c = prog.LFBudgId__c;
        }
        update listTestData;
    }

    @isTest
    static void batchClassPositiveTest(){
        Test.startTest();
        ContactStagingToContactConversionBatch batchClass = new ContactStagingToContactConversionBatch();
        batchClass.isTest = true;
        Id batchId = Database.executeBatch(batchClass);
        Test.stopTest();

        Sync_History__c updatedBatch = [SELECT Id, Total_Records_Converted__c,Total_Failed_Conversions__c FROM Sync_History__c WHERE Status__c = 'Uploaded' LIMIT 1][0];
        List<Contact> listTargetRecs = [SELECT Id FROM Contact];
        List<Account> listAffiliations = [SELECT Id FROM Account WHERE RecordType.Name = 'Organization'];
        List<Email_Address__c> listEmails = [SELECT Id FROM Email_Address__c];
        System.assertEquals(200, updatedBatch.Total_Records_Converted__c);
        System.assert(listAffiliations.size() > 0);
        System.assert(listEmails.size() > 0);
    }
}