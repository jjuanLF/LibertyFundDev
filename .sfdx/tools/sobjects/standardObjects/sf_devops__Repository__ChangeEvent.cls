// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Repository__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global User Owner;
    global Id OwnerId;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global String sf_devops__Default_Branch__c;
    global String sf_devops__GitHub_Owner__c;
    global String sf_devops__GitHub_Repo__c;
    global String sf_devops__Last_Event__c;
    global String sf_devops__Named_Credential__c;
    global Double sf_devops__Polling_Interval__c;
    global String sf_devops__Provider__c;

    global sf_devops__Repository__ChangeEvent () 
    {
    }
}