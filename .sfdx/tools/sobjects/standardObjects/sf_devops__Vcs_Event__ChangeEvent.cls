// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Vcs_Event__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global sf_devops__Repository__c sf_devops__Repository__c;
    global Datetime sf_devops__Event_Date__c;
    global String sf_devops__Event_Id__c;
    /* Managed by the DevOps Center, when this VCS Event has been handled/resolved, this value will be updated to true automatically.
    */
    global Boolean sf_devops__Handled__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Operation_Status__c;
    global String sf_devops__Payload__c;
    global String sf_devops__Source_Branch__c;
    global String sf_devops__Target_Branch__c;
    global sf_devops__Pipeline_Stage__c sf_devops__Target_Pipeline_Stage__c;
    global sf_devops__Work_Item__c sf_devops__Target_Work_Item__c;

    global sf_devops__Vcs_Event__ChangeEvent () 
    {
    }
}