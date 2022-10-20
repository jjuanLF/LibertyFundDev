/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 02/17/2016
Description: This class is used to test web services. Its created when the code being tested
			 does a call out. This class will be created by the MockCallouts class and should
			 never be created by the developer. 
Changes: 
*********************************************************************************************/ 
@isTest
global with sharing class MockHTTPResponseGenerator implements HTTPCalloutMock {
    
	global String sResponseBody;
	global Integer iStatusCode = 200;
	global String sStatus = 'OK';
		
	global MockHttpResponseGenerator(String sBody) {
		sResponseBody = sBody;
	}
    
    global httpResponse respond(HTTPRequest oHTTPRequest) {
        HTTPResponse oHTTPResponse = new httpResponse();
        oHTTPResponse.setHeader('Content-Type', 'application/json');
        oHTTPResponse.setBody(sResponseBody);
        oHTTPResponse.setStatusCode(iStatusCode);
        oHTTPResponse.setStatus(sStatus);
        return oHTTPResponse;
    }    
}