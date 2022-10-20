/*********************************************************************************************
Created By: Sam Brandenburg
Email: sam.brandenburg@revelanttech.com
Created: 1/25/2020
Description: Class responsible for sending a suggestion list to legacy system
Changes:    Updated to incorporate entire MyListConferees into the request as a list   
*********************************************************************************************/
public class MyListService {
    
    /**
     * @description: Invoked from a screen flow, gives the record id to process and determines whether it is a contact or a lead
     * @param: requestFromFlow: List of record IDs that should be the Suggestion_List__c type
    **/
    @InvocableMethod(label='Send MyList' description='Send MyList to Conference DB' callout=true)
    public static List<String> invoke(List<Id> myListId) {
        
        Id myListRecordId;
        List<Id> lContactIds = New List<Id>();
        List<Id> lLeadIds = New List<Id>();
        Map<Id, Contact> mContacts = New Map<Id, Contact>();
        Map<Id, Lead> mLeads = New Map<Id, Lead>();
        String requestJSON;
        String returnString;
        List<String> returnWrapper = new List<String>();
        
        //Get record Id, there should ever only be one
        for (Id recordId : myListId) {
            myListRecordId = recordId;
        }
        
        //Query suggestionlist and related child conferee records
        MyList__c myList = [Select Id, Name, Campaign__r.E_number__c, Description__c, 
                                             (Select Id, Contact__c, Lead__c, Notes__c  From MyList_Conferees__r) 
                                             From MyList__c
                                             Where Id =: myListRecordId];
        
        //check to see if the related child records exist:
        List<MyList_Conferee__c> conferees = myList.getSobjects('MyList_Conferees__r');
        if (conferees != null && conferees.size() > 0) {
            
            //Query metadata setting
            MyList_API_Settings__mdt myListSetting = [Select Id, DeveloperName, Bearer_Token__c, Debug_Emails__c, Enable_Logging__c, Endpoint_URL__c
                                     From MyList_API_Settings__mdt
                                     Where DeveloperName = 'DEFAULT'];

            // Get a list of the Contacts and Leads specified in the MyList
            for (MyList_Conferee__c conferee : conferees) {
                if (conferee.Contact__c != null) {
                    lContactIds.add(conferee.Contact__c);
                }
                if (conferee.Lead__c != null) {
                    lLeadIds.add(conferee.Lead__c);
                }
            }
            
            // create maps of the Contacts and Leads in the List
            for (Contact oContact : [SELECT Id, AccountId, Salutation, FirstName, LastName, Title, LFPID__c, Website__c FROM Contact WHERE Id IN :lContactIds]) {
                mContacts.put(oContact.Id, oContact);
            }
            for (Lead oLead : [SELECT Id, FirstName, LastName, Company, Title, Website FROM Lead WHERE Id IN :lLeadIds]) {
                mLeads.put(oLead.Id, oLead);
            }
            
            //Init response
            MyListResponse.ResponsePayload responseDetails = new MyListResponse.ResponsePayload();
        
            //Init Request
            MyListRequest.MyListRequestPayload requestBody = new MyListRequest.MyListRequestPayload();
        
            // start building the request
            requestBody.user_name = UserInfo.getUserEmail();
            requestBody.list_name = myList.Name;
            requestBody.ack_emails = new List<String>();
            requestBody.liberty_id = myList.Campaign__r.E_number__c;
            requestBody.suggestions = New List<MyListRequest.Suggestion_data>();
        
            //If any alert emails are set, add them into payload
            if (String.isNotBlank(myListSetting.Debug_Emails__c)) {
                List<String> alertEmails = myListSetting.Debug_Emails__c.split(',');
                for (String emailAddress : alertEmails) {
                    requestBody.ack_emails.add(emailAddress);
                }
            }
            
            for (MyList_Conferee__c conferee : conferees) {

                MyListRequest.Suggestion_data oSugg = New MyListRequest.Suggestion_data();
                
                // CONTACT
                if (conferee.Contact__c != null) {
                    Contact oContact = mContacts.get(conferee.Contact__c);
                    oSugg.pid = (oContact.LFPID__c != null && oContact.LFPID__C != '') ? integer.valueOf(oContact.LFPID__c) : null;
                    oSugg.comments = conferee.Notes__c;

                    // person_data section
                    oSugg.person_data = New MyListRequest.Person_data();
                    oSugg.person_data.sf_id = oContact.Id;
                    oSugg.person_data.prefix = oContact.Salutation;
                    oSugg.person_data.first = oContact.FirstName;
                    //oSugg.person_data.middle = oContact.MiddleName;
                    oSugg.person_data.last = oContact.LastName;
                    //oSugg.person_data.suffix = oContact.Suffix;
                    oSugg.person_data.url = oContact.Website__c;
                    
                    // affiliations
                    oSugg.person_data.aff = New List<MyListRequest.Aff>();
                    /*List<npe5__Affiliation__c> lAffil = [SELECT Id, npe5__Organization__r.Name, npe5__Primary__c, Affiliation_Title_Role__c
                                                     FROM npe5__Affiliation__c 
                                                     WHERE npe5__Contact__c = :oContact.Id];
                    if (lAffil.size() > 0) {
                        MyListRequest.Aff oReqAffil = new MyListRequest.Aff();
            
                        for (npe5__Affiliation__c oAffil : lAffil) {
                            oReqAffil.organization = oAffil.npe5__Organization__r.Name;
                            oReqAffil.title = oAffil.Affiliation_Title_Role__c;
                            oReqAffil.primary = oAffil.npe5__Primary__c;
                            oSugg.person_data.aff.add(oReqAffil);
                        }
                    }*/
                    
                    // emails list
                    List<Email_Address__c> lEmails = [SELECT Id, Email__c, Correspondence_Email__c, Public_Email__c
                                                      FROM Email_Address__c
                                                      WHERE Contact__c = :oContact.Id];
                    if (lEmails.size() > 0 ) {
                        oSugg.person_data.emails = new List<MyListRequest.Emails>();
                        MyListRequest.Emails oReqEmail = new MyListRequest.Emails();
                        
                        for (Email_Address__c oEmail : lEmails) {
                            oReqEmail.address = oEmail.Email__c;
                            oReqEmail.for_correspondence = oEmail.Correspondence_Email__c;
                            oReqEmail.for_list = oEmail.Public_Email__c;
                            oSugg.person_data.emails.add(oReqEmail);
                        }
                    }
        
                    // addresses list
                    /* List<npsp__Address__c> lAddrs = [SELECT Id, npsp__MailingStreet__c, npsp__MailingStreet2__c, npsp__MailingCity__c,
                                                     npsp__MailingState__c, npsp__MailingPostalCode__c, npsp__MailingCountry__c,
                                                     Send_Mail__c, Phone__c, Mobile_Phone__c, FAX__c, Other_Phone__c
                                                     FROM npsp__Address__c
                                                     WHERE npsp__Household_Account__c = :oContact.AccountId];
                    if (lAddrs.size() > 0) {
                        oSugg.person_data.addresses = new List<MyListRequest.Addresses>();
                        MyListRequest.Addresses oReqAddr = new MyListRequest.Addresses();
                        
                       for (npsp__Address__c oAddr : lAddrs){
                            oReqAddr.addr1 = oAddr.npsp__MailingStreet__c;
                            oReqAddr.addr2 = oAddr.npsp__MailingStreet2__c;
                            oReqAddr.addr3 = null;
                            oReqAddr.city = oAddr.npsp__MailingCity__c;
                            oReqAddr.state = oAddr.npsp__MailingState__c;
                            oReqAddr.zip = oAddr.npsp__MailingPostalCode__c;
                            oreqAddr.country = oAddr.npsp__MailingCountry__c;
                            oReqAddr.for_correspondence = oAddr.Send_Mail__c;
                            oReqAddr.for_list = null;
                            oReqAddr.organization = null;
                            oReqAddr.phone1 = oAddr.Phone__c;
                            oReqAddr.phone2 = oAddr.Mobile_Phone__c;
                            if ((oAddr.FAX__c != '') && (oAddr.FAX__c != null)) {
                                oReqAddr.phone3 = oAddr.FAX__c;
                                oReqAddr.phType3 = 'FAX';
                            }
                            if ((oAddr.Other_Phone__c != '') && (oAddr.Other_Phone__c != null)) {
                                oReqAddr.phone4 = oAddr.Other_Phone__c;
                                oReqAddr.phType4 = 'Other';
                            }
                            oSugg.person_data.addresses.add(oReqAddr);
                        }
                    }*/
                    

                // LEAD
                } else if (conferee.Lead__c != null) {
                    Lead oLead = mLeads.get(conferee.Lead__c);
                    oSugg.comments = conferee.Notes__c;

                    // person_data section
                    oSugg.person_data = New MyListRequest.Person_data();
                    oSugg.person_data.sf_id = oLead.Id;
                    oSugg.person_data.first = oLead.FirstName;
                    oSugg.person_data.last = oLead.LastName;
                    oSugg.person_data.url = oLead.Website;

                    // affiliation (map company/title from Lead into a single affiliation)
                    oSugg.person_data.aff = New List<MyListRequest.Aff>();
                    MyListRequest.Aff oReqAffil = new MyListRequest.Aff();
                    oReqAffil.organization = oLead.Company;
                    oReqAffil.title = oLead.Title;
                    oReqAffil.primary = true;
                    oSugg.person_data.aff.add(oReqAffil);
                }
                
                requestBody.suggestions.add(oSugg);
            }
            
            //Build request
            requestJSON = JSON.serialize(requestBody, true);
            returnString = sendMyListRequest(requestJSON);
            
        } else {
            System.debug('No associated Conferee records found for MyList__c: ' + myListRecordId);
        }

        returnWrapper.add(returnString);
        return returnWrapper;
        
    }

    
    /**
    * @description: Sends complete payload to external service
    * @param: Payload to send
    **/
    //@future(callout=true)
    public static String sendMyListRequest(String requestJSON) {
        
        String returnString;
        
        //Init response
        MyListResponse.ResponsePayload responseDetails = new MyListResponse.ResponsePayload();
                
        //Query metadata setting
        MyList_API_Settings__mdt myListSetting = [Select Id, DeveloperName, Bearer_Token__c, Debug_Emails__c, Enable_Logging__c, Endpoint_URL__c
                                 From MyList_API_Settings__mdt
                                 Where DeveloperName = 'DEFAULT'];
        
        //Build request
        MyListRequest transmitRequest = new MyListRequest(myListSetting.Endpoint_URL__c, requestJSON, 'POST');
        
        //Send Request
        MyListResponse response = new MyListResponse(WebServiceManager.processRequest(transmitRequest));
        
        //Evaluate response
        if (response.getStatusCode() == 200 || response.getStatusCode() == 201 || response.getStatusCode() == 204) {
            responseDetails = response.getResponseData();
            //do something with response data here:
            System.debug('responseDetails.status:  ' + responseDetails.status);
            System.debug('responseDetails.transaction_id:  ' + responseDetails.transaction_id);
            System.debug('responseDetails.message:  ' + responseDetails.message);
            if (responseDetails.status.toLowerCase() == 'ok') {
                returnString = responseDetails.status + ':' + responseDetails.transaction_id;
            } else {
                returnString = responseDetails.status + ':' + responseDetails.message;
            }
        } else {
            //Additional debugs can be added here
            System.debug('Error: ' + responseDetails);
        }

        //Save off integration logs
        IntegrationLogService.save();
        
        return returnString;
    }
/**    
    public static void coverageMethod() {
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
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
    }
**/
}