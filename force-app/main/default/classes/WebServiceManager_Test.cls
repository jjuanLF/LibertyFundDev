/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 01/04/2017
Description: Class used to test the WebServiceManager class. It uses the MockCallouts class that 
			 can be used for multiple callouts. Just use the "add" method to add as many endpoints 
			 that will be called for the test method. 

Changes: 
*********************************************************************************************/  
@isTest
private with sharing class WebServiceManager_Test {
	
	static testMethod void test_HTTPRequestElement_example() {
 		MockCallouts oMockCallouts = new MockCallouts();
      	oMockCallouts.add('https://jsonplaceholder.typicode.com/posts/1', '{"userId": 1, "id": 1, "title": "This is the title", "body": "This is the body"}');
		Test.setMock(HttpCalloutMock.class, oMockCallouts.getMockCallout());
		Test.startTest(); 
        	try{  
				HTTPRequestElement oHTTPRequestElement_example = new HTTPRequestElement_example();
				HTTPResponseElement_example oHTTPResponseElement_example = new HTTPResponseElement_example(WebServiceManager.processRequest(oHTTPRequestElement_example));
				HTTPResponseElement_example.JSONData oJSONData = oHTTPResponseElement_example.getResponseData();
				System.assertEquals('This is the title', oJSONData.title);
            }catch(Exception oException){              
        		System.assertEquals(null, oException.getMessage());
            }           
        Test.stopTest();			
	}   

  	static testMethod void test_HTTPRequestElement_calloutException() {
        try {
			Test.startTest(); 
            throw new WebServiceManagerException.CallOutException('testing exception');
	        Test.stopTest();			
        } catch (Exception oException) {
            
        }
    }

  	static testMethod void test_HTTPRequestElement_invaldParamException() {
        try {
			Test.startTest(); 
            throw new WebServiceManagerException.InvalidParameterException('testing exception');
	        Test.stopTest();			
        } catch (Exception oException) {
            
        }
    }
  	static testMethod void test_HTTPRequestElement_nullPointerException() {
        try {
			Test.startTest(); 
            throw new WebServiceManagerException.NullPointerException('testing exception');
	        Test.stopTest();			
        } catch (Exception oException) {
            
        }
    }
}