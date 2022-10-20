// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Source_Member_Reference__ChangeEvent {
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
    global sf_devops__Remote_Change__c sf_devops__Remote_Change__c;
    global Boolean sf_devops__Is_Delete__c;
    global Boolean sf_devops__Is_New__c;
    global Double sf_devops__Revision_Counter__c;
    global String sf_devops__Source_Member_Id__c;

    global sf_devops__Source_Member_Reference__ChangeEvent () 
    {
    }
}