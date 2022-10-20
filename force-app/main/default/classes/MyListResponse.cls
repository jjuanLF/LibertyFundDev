/*********************************************************************************************
Created By: Sam Brandenburg
Email: sam.brandenburg@revelanttech.com
Created: 1/25/2020
Description: Class responsible for deserializing a MyList request
*********************************************************************************************/
public class MyListResponse extends HttpResponseElement{
	/** 
    * @description: Set the response object
    **/ 
    public MyListResponse(HttpResponse oHttpResponse) {
        setResponse(oHttpResponse);
    }
    
    /** 
    * @description: deserialize the response data into a class object
    **/
    public ResponsePayload getResponseData() {
        //Get the response details
        String responseBody = getBody();
        String status = getStatus();
        Map<String,String> headers = getHeaders();
        return (ResponsePayload)JSON.deserialize(responseBody, ResponsePayload.class);
    }
    
    @TestVisible
    public class ResponsePayload {
        @TestVisible
        public String status;
        @TestVisible
        public String message;	// populated if status="error"
        @TestVisible
        public String transaction_id;	// populated if status="ok"
    }
}