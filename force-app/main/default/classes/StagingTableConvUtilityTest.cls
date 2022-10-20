@isTest
private class StagingTableConvUtilityTest {
//StagingTableConversionUtility is also covered by the various "conversionBatch" test classes
//This test class focuses on testing the two exception handling methods in the utility class
    @isTest
    static void batchClassPositiveTest_FailedUpsertAccount(){
        Test.startTest();
        AccountStagingTable__c accST = new AccountStagingTable__c(Company_Name__c = 'Test Company');
        insert accSt;
        Account accFail = new Account(Name = 'Really long name that is definitely going to exceed the character limit for standard name fields');
        
        Schema.DescribeFieldResult dfrExtId = Account.LF_Vendor_ID__c.getDescribe();
        Schema.SObjectField extId = dfrExtId.getSObjectField();
        List<Database.UpsertResult> listUpsertResults = Database.upsert(new List<Account>{accFail}, extId, false);

        Map<Id, Database.UpsertResult> mapSourceRecIdToUpsertResult = new Map<Id, Database.UpsertResult>();
        mapSourceRecIdToUpsertResult.put(accST.Id, listUpsertResults[0]);
        List<Exception__c> listExc = StagingTableConversionUtility.logFailedUpsertsAsExceptions(
            mapSourceRecIdToUpsertResult, 'AccountStagingTable__c', null, 'test account insert exception');
        Test.stopTest();

        System.assert(listExc.size() == 1);
    }
    
    @isTest
    static void batchClassPositiveTest_FailedUpsertContact(){
        Test.startTest();
        ContactStagingTable__c contST = new ContactStagingTable__c(Last_Name__c = 'Testerson');
        insert contSt;
        Contact conFail = new Contact(LastName = 'Testerson', Correspondence_Email__c = 'invalid@email');
        
        Schema.DescribeFieldResult dfrExtId = Contact.LFPID__c.getDescribe();
        Schema.SObjectField extId = dfrExtId.getSObjectField();
        List<Database.UpsertResult> listUpsertResults = Database.upsert(new List<Contact>{conFail}, extId, false);

        Map<Id, Database.UpsertResult> mapSourceRecIdToUpsertResult = new Map<Id, Database.UpsertResult>();
        mapSourceRecIdToUpsertResult.put(contST.Id, listUpsertResults[0]);
        List<Exception__c> listExc = StagingTableConversionUtility.logFailedUpsertsAsExceptions(
            mapSourceRecIdToUpsertResult, 'ContactStagingTable__c', null, 'test contact insert exception');
        Test.stopTest();

        System.assert(listExc.size() == 1);
    }
    
    @isTest
    static void batchClassPositiveTest_FailedTryCatch(){
        Test.startTest();
		Integration_Staging_Table_Field_Mapping__mdt invalidMapping = new Integration_Staging_Table_Field_Mapping__mdt();
        invalidMapping.MasterLabel = 'Test CMT';
        invalidMapping.DeveloperName = 'TestCMT';
        invalidMapping.Source_Object__c = 'AccountStagingTable__c';
        invalidMapping.Source_Field__c = 'Hotel_URL__c';
        invalidMapping.Target_Object__c = 'Account';
        invalidMapping.Target_Field__c = 'Htol_URL_c';
        Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>> mapSourceFieldToTargetList = new Map<String, List<Integration_Staging_Table_Field_Mapping__mdt>>();
        mapSourceFieldToTargetList.put('Hotel_URL__c', new List<Integration_Staging_Table_Field_Mapping__mdt>{invalidMapping});
        
        AccountStagingTable__c accST = new AccountStagingTable__c(Hotel_URL__c = 'www.google.com');
        insert accST;
        Map<String, Sobject> mapExtIdToSourceRecord = new Map<String, Sobject>();
        mapExtIdToSourceRecord.put('extId', accST);
        
        Map<String, Sobject> mapExtIdToTargetRecord = StagingTableConversionUtility.generateTargetRecordFromMapping(
                                            mapExtIdToSourceRecord, mapSourceFieldToTargetList, null);
		Test.stopTest();
            
        List<Exception__c> listExc = [SELECT Id FROM Exception__c];
        System.assert(listExc.size() == 1);
    } 
}