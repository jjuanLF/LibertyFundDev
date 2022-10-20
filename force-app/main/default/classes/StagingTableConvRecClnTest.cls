@isTest
public class StagingTableConvRecClnTest {

	@testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
    }
    
    @isTest
    static void cleanupClassPositiveTest(){
        System.assertEquals('Uploaded', [SELECT Id, Status__c FROM Sync_History__c LIMIT 1][0].Status__c);
        
        Test.startTest();
        StagingTableConversionRecordCleanUp batchClass = new StagingTableConversionRecordCleanUp();
        //batchClass.isTest = true;
        Id batchId = Database.executeBatch(batchClass);
        Test.stopTest();
        
        System.assertEquals('Converted', [SELECT Id, Status__c FROM Sync_History__c LIMIT 1][0].Status__c);
    }
}