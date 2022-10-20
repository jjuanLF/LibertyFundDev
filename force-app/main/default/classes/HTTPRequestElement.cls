/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 12/05/2016
Description: Extend this class with the request data to call the web service framework. Look
			 at the example classes for help.
Changes: 
*********************************************************************************************/  
public abstract class HTTPRequestElement {
	
    private String sEndPoint = '';
    private String sMethod = '';
	private String sBody = '';
	private Integer iTimeout = 120000;
    private Map<String, String> mHeaders = new Map<String, String>();
    
	/** 
	* @description Get the endpoint to be called
	*/      
    public String getEndPoint() {
        return sEndPoint;
    }    
    
    /** 
	* @description The endpoint to be called
	*/
    public void setEndPoint(String sValue) {
        sEndPoint = sValue;
    }

	/** 
	* @description Get the HTTP timeout for the callout
	*/
    public Integer getTimeout() {
        return iTimeout;
    }
    
    /** 
	* @description Set the timeout for the callout. Default is 120000
	*/    
    public void setTimeout(Integer sValue) {
        iTimeout = sValue;
    }
    
	/** 
	* @description Get the HTTP method to be used for the callout
	*/
    public String getMethod() {
        return sMethod;
    }
    
    /** 
	* @description Set the HTTP method to be used for the callout
	*/    
    public void setMethod(String sValue) {
        sMethod = sValue;
    }

	/** 
	* @description Get the request body to be used for the callout
	*/
    public String getBody() {
        return sBody;
    }    
    
    /** 
	* @description Set the request body to be used for the callout
	*/
    public void setBody(String sValue) {
        sBody = sValue;
    }
    
    /** 
	* @description Set a header for the request
	* @param String - Header Key (example: Content-Type ) 
	* @param String - Header Value (example: application/json) 
	*/
    public void setHeader(String sKey, String sValue) {
        mHeaders.put(sKey, sValue);
    }

	/** 
	* @description Build and return the HTTPRequst object to be used for the callout
	* @return HTTPRequest to be used for the callout
	*/
    public HTTPRequest getRequest() {
    	// Create the HTTP Request object
    	HttpRequest oHttpRequest = new HttpRequest();
    	// Loop through the headers in cache
    	if (mHeaders != null && !mHeaders.isEmpty()) {
    		for (String sKey : mHeaders.keySet()) {
    			// Create a header on the Request object for each one in cache
    			oHttpRequest.setHeader(sKey, mHeaders.get(sKey));
    		}
    	}
    	// Set the HTTP method on the Request object
    	oHttpRequest.setMethod(sMethod);
        // Check to see if the body has been set
        if (String.isNotBlank(sBody)) {
        	// Set the body on the Request object
        	oHttpRequest.setBody(sBody);
        }
        // Set the Timeout on the request object
        oHttpRequest.setTimeout(iTimeout);
        // return the Request object
        return oHttpRequest;
    }
}