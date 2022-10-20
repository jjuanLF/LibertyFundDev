/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 12/05/2016
Description: This class is a example implementation of the HttpResponseElement abstract class. A class
			 similar to this one will need to be created for each unique endpoint called. 
			 
			 This class should also contain sub classes to deserialize the JSON body in the Response object. 
			 Everything needed for the response of a specific endpoint should be contained within this class.
			 
			 Follow the installation instuctions below to run this example class.
			 
			 1. Create a Remote Site Setting
			 	
			 	Remote Site Name: HTTPRequestElementExample
			 	Remote Site URL: https://jsonplaceholder.typicode.com/
Changes: 
*********************************************************************************************/  
public with sharing class HTTPResponseElement_example extends HttpResponseElement {

	/** 
	* @description Set the response object
	*/  
	public HTTPResponseElement_example(HttpResponse oHttpResponse) {
		setResponse(oHttpResponse);
	}	    
	
	/** 
	* @description Return the deserialized response JSON data 
	*/ 
	public JSONData getResponseData(){
		return (HTTPResponseElement_example.JSONData)JSON.deserialize(getBody(), HTTPResponseElement_example.JSONData.class);	
	}
		
	/** 
	* @description Sub class used to deserialize the JSON data in the response body. Create as many subclasses need to 
	*			   fully deserialize the response data 
	*/ 			
	public class JSONData {
		public Integer userId;
		public Integer id;
		public String title;
		public String body;		
	}
}