/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 12/05/2016
Description: Class repsonsible for calling web services. Takes in a HTTP Request object and
			 returns a HTTP Response object. If any speical authenication is required for the 
			 web service, add the logic here.
Changes: 
*********************************************************************************************/  
public class WebServiceManager {
    
    public static MyList_API_Settings__mdt myListSetting;
    
    //Query custom setting to set auth
    static {
        myListSetting = [Select Id, DeveloperName, Bearer_Token__c, Debug_Emails__c, Enable_Logging__c, Endpoint_URL__c
                                 From myList_API_Settings__mdt
                                 Where DeveloperName = 'DEFAULT'];
    }
    
    /**
     * @description: This builds the HTTPRequest and sends the web service callout
     * @param: eventType: constructed http request element
    **/
	public static HttpResponse processRequest(HTTPRequestElement oHTTPRequestElement) {
		
        //Make sure we received appropiate argument
		if (oHTTPRequestElement == null){
			throw new WebServiceManagerException.InvalidParameterException('Invalid Parameter Exception');
		}

        //Retrieve Request
		HttpRequest oHttpRequest = oHTTPRequestElement.getRequest();
		
        //Make sure HTTP request is part of element
        if (oHttpRequest == null){
        	throw new WebServiceManagerException.NullPointerException('There was a problem building the request.');
        }

        Http http = new Http();
        //Set endpoint (requires remote site setting)
        oHttpRequest.setEndPoint(oHttpRequestElement.getEndPoint());
        //Add headers
        oHttpRequest.setHeader('Content-Type', 'application/json');
        oHttpRequest.setHeader('Authorization', 'Bearer ' + myListSetting.Bearer_Token__c);
        System.debug('WebServiceManager.processRequest(): Endpoint - ' + oHttpRequest.getEndPoint());
        System.debug('WebServiceManager.processRequest(): Request ====> ');
        System.debug('WebServiceManager.processRequest() - Body:' + oHttpRequest.getBody());
        System.debug('WebServiceManager.processRequest() - Method:' + oHttpRequest.getMethod());
        //Send request
        HttpResponse oHttpResponse = http.send(oHttpRequest);
		System.debug('WebServiceManager.processRequest(): Response <==== ');
        System.debug('WebServiceManager.processRequest(): ' + oHttpResponse.getBody());
        
        //Handle response
        if (oHttpResponse == null){
        	throw new WebServiceManagerException.CallOutException('There was a problem performing the callout.');
        }
        
        if (myListSetting.Enable_Logging__c) {
            IntegrationLogService.storeCallout(oHttpRequest, oHttpResponse);
        }
                 
        return oHttpResponse;
    }    
}