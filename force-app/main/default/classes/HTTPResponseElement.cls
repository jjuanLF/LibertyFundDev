/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 12/05/2016
Description: Extend this class with the reponse data for recieving data from using the 
			 web service framework.
Changes: 
*********************************************************************************************/  
public abstract class HTTPResponseElement {
    
	private HTTPResponse oHttpResponse = new HTTPResponse();
	
	/** 
	* @description Set the HTTP Response object 
	*/  
	public void setResponse(HTTPResponse oResponse) {
        oHttpResponse = oResponse;
    }
	
	/** 
	* @description Get the body of HTTP Response object 
	*/    
    public String getBody() {
    	return oHttpResponse.getBody();
    }
    
    /** 
	* @description Get the status of HTTP Response object 
	*/
    public String getStatus() {
    	return oHttpResponse.getStatus();
    }
    
    /** 
	* @description Get the status code of HTTP Response object 
	*/
    public Integer getStatusCode() {
    	return oHttpResponse.getStatusCode();
    }

    /** 
	* @description Get the header keys of HTTP Response object 
	*/    
    public String[] getHeaderKeys() {
    	return oHttpResponse.getHeaderKeys();
    }
    
    /** 
	* @description Get the header value
	* @param String - Header key to get value for  
	*/    
    public String getHeader(String sKey) {
    	return oHttpResponse.getHeader(sKey);
    }   
    
    /** 
	* @description Get a map of header keys to header values for the response object 
	*/    
    public Map<String, String> getHeaders() {
    	// Create a map to hold the headers
    	Map<String, String> mHeaders = new Map<String, String>();
    	// Get the list of header keys
		String[] lHeaderKeys = oHttpResponse.getHeaderKeys();
		// Loop through the header keys and add them to the map
		for(String sHeaderKey : lHeaderKeys){
			mHeaders.put(sHeaderKey, oHttpResponse.getHeader(sHeaderKey));
		}
		//return the map
		return mHeaders;
    } 
}