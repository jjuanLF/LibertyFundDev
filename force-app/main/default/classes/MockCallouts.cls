/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 02/17/2016
Description: The base class used to test call outs. It contains a map of endpoints assocaited
			 to a corresponding instance of the HTTPCalloutMock class.
Changes: 
*********************************************************************************************/ 
public with sharing class MockCallouts {

	private final Map<String, HTTPCalloutMock> mCallouts;
    	
	public MockCallouts() {
		mCallouts = new Map<String, HTTPCalloutMock>();
	}
    	
	public void add(String sEndPoint, String sResponse) {
		MockHTTPResponseGenerator oMockHTTPResponseGenerator = new MockHTTPResponseGenerator(sResponse);
		mCallouts.put(sEndPoint, oMockHTTPResponseGenerator);
	}
    	
	public void add(String sEndPoint, String sResponse, Integer iStatusCode, String sStatus) {
		MockHTTPResponseGenerator oMockHTTPResponseGenerator = new MockHTTPResponseGenerator(sResponse);
		oMockHTTPResponseGenerator.iStatusCode = iStatusCode;  
		oMockHTTPResponseGenerator.sStatus = sStatus;
		mCallouts.put(sEndPoint, oMockHTTPResponseGenerator);
	}
    	
	public HTTPCalloutMock getMockCallout() {
		return new MultiMockHTTPResponseGenerator(mCallouts);
	}
}