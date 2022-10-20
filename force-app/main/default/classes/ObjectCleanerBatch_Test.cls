/*********************************************************************************************
  Created By: Sam Brandenburg
  Email: sam.brandenburg@revelanttech.com
  Created: 03/23/2017
  Notes:  Unit Test for ObjectCleanerBatch.class
  *********************************************************************************************/
@isTest
private class ObjectCleanerBatch_Test {
	
	@isTest 
    static void test_ObjectCleanerBatchExecute() {
		
		Test.startTest();
		Database.executeBatch(new ObjectCleanerBatch(0), 200);
		Test.stopTest();
	}

	@isTest 
    static void test_ObjectCleanerBatchSchedule() {

		Test.startTest();
		ObjectCleanerBatch batch = new ObjectCleanerBatch(0);
		batch.execute(null);
		Test.stopTest();
	}
    
    @isTest
    static void test_additionalTestCoverate() {
        Test.startTest();
        ObjectCleanerBatch.testCoverageString();
        Test.stopTest();
    }
}