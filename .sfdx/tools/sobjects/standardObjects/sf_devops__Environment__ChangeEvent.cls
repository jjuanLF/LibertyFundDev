// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Environment__ChangeEvent {
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
    global sf_devops__Project__c sf_devops__Project__c;
    global Boolean sf_devops__Can_Track_Changes__c;
    global Double sf_devops__Last_Revision_Counter__c;
    global String sf_devops__Named_Credential__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Operation_Result__c;
    global Boolean sf_devops__Test_Environment__c;

    global sf_devops__Environment__ChangeEvent () 
    {
    }
}