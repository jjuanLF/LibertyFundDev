/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 02/17/2016
Description: This class is used to test web services. Its responsible for returning the correct
			 instance of the HTTPCalloutMock class mapped to an endpoint. The endpoint must be
			 the exact same the code will call or the "Endpoint not found" error will occur. 
Changes: 
*********************************************************************************************/ 
public with sharing class MultiMockHTTPResponseGenerator implements HTTPCalloutMock {

	Map<String, HTTPCalloutMock> mRequests;
	
	public MultiMockHTTPResponseGenerator(Map<String, HTTPCalloutMock> mRequests) {
		this.mRequests = mRequests;
	}
	
	public HTTPResponse respond(HTTPRequest oHTTPRequest) {
        integer i;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
		HTTPCalloutMock oHTTPCalloutMock = mRequests.get(oHTTPRequest.getEndpoint());
		if (oHTTPCalloutMock != null){
			return oHTTPCalloutMock.respond(oHTTPRequest);
		}else{
    		throw new WebServiceManagerException.CallOutException('Endpoint not found: ' + oHTTPRequest.getEndpoint());
		}	
	}
	
	public void addRequestMock(String sUrl, HTTPCalloutMock oHTTPCalloutMock) {
		mRequests.put(sUrl, oHTTPCalloutMock);
	}	 
}