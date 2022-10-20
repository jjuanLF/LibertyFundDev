@isTest
private class StagingTableConvSchTest {
	@testSetup
    static void loadTestDataFromStaticResource(){
        Sync_History__c batch = TestDataFactory.getBatch();
    }
    
    @isTest
    static void scheduleClassPositiveTest(){
        Date nextRun = Date.today().addMonths(1);
        String cronExp = '0 0 0 ' + String.valueOf(nextRun.day()) + ' ' + String.valueOf(nextRun.month()) + ' ? ' + String.valueOf(nextRun.year()); //Seconds Minutes Hours DayOfMonth Month DayOfWeek Year
        
        Test.startTest();
        String jobId = System.schedule('testStagingTableConversionSchedule', cronExp, new StagingTableConversionSchedule());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cronExp, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals(String.valueOf(nextRun) + ' 00:00:00', String.valueOf(ct.NextFireTime));
        System.assertEquals('Uploaded', [SELECT Id, Status__c FROM Sync_History__c LIMIT 1][0].Status__c);
        Test.stopTest();
        //Once stopTest is executed, the System.schedule method runs.
        
        System.assertEquals('Conversion in Progress', [SELECT Id, Status__c FROM Sync_History__c LIMIT 1][0].Status__c);
        System.assertEquals('Queued', [SELECT Id, ApexClass.Name, Status, JobType FROM AsyncApexJob WHERE ApexClass.Name = 'AccountStagingToAccountConversionBatch' LIMIT 1][0].Status);
    }
}