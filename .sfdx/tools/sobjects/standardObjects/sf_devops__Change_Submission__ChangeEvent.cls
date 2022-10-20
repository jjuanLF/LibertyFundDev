// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Change_Submission__ChangeEvent {
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
    global String sf_devops__Comment__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Creation_Result__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Inspection_Result__c;
    global String sf_devops__Modified_Remote_Changes__c;
    global Boolean sf_devops__Open_Beta_Migrated__c;
    global String sf_devops__Prior_Remote_Reference__c;
    global String sf_devops__Remote_Reference__c;
    global String sf_devops__Removed_Remote_Changes__c;
    global String sf_devops__Submitted_By_Name__c;
    global User sf_devops__Submitted_By__c;
    global Datetime sf_devops__Submitted_On__c;
    global sf_devops__Work_Item__c sf_devops__Work_Item__c;

    global sf_devops__Change_Submission__ChangeEvent () 
    {
    }
}