/*********************************************************************************************
Created By: Sam Brandenburg
Email: sam.brandenburg@revelanttech.com
Created: 01/25/20
Description: This class is responsible for creating outgoing log files when SFDC performs a callout
Changes:   
*********************************************************************************************/
public class IntegrationLogService {

/** 
    * @description: list to hold integration logs that need to be created
    **/
	private static List<Integration_Log__c> integrationLogs = new List<Integration_Log__c>();

	/**
     * @description: This method stores log record that need to be created
     * @param: oRequest: Outbound Request
     * @param: oResponse: Response from callout
    **/
	public static void storeCallout(HttpRequest oRequest, HttpResponse oResponse) {

		try {

			Integration_Log__c newLog = new Integration_Log__c();
			//Store request details
			newLog.Request_Method__c = oRequest.getMethod();
			newLog.Request_URL__c = oRequest.getEndpoint();
			newLog.Request_Body__c = oRequest.getBody();

			//Store response details
			newLog.Response_Body__c = oResponse.getBody();
			newLog.Response_Status__c = oResponse.getStatus();
			newLog.Response_Status_Code__c = oResponse.getStatusCode();

			//Set the disposition if there's an error
			if (oResponse.getStatusCode() == 200 || oResponse.getStatusCode() == 201 || oResponse.getStatusCode() == 204) {
				newLog.Disposition__c = oResponse.getStatus();
			} else {
				newLog.Disposition__c = 'Error: See log for details';
			}

			integrationLogs.add(newLog); 

		} catch (Exception oException) {
			System.debug('IntegrationLogService.storeCallout() Exception: ' + oException.getMessage() + ' -- Line: ' + oException.getLineNumber());
		} 
	}

	/**
     * @description: This method saves all log records that have been stored
     * @return: N/A
    **/
	public static void save() {

		System.debug('IntegrationLogService.save() called: ' + integrationLogs);

		//Save the integration logs
		if (integrationLogs.size() > 0) {
			insert integrationLogs;
		}

		//Clear it out to prevent duplicate calls
		integrationLogs.clear();
	}
}