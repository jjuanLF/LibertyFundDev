// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Object_Activity__ChangeEvent {
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
    global Datetime sf_devops__Activity_Date__c;
    global String sf_devops__Activity_Type__c;
    global sf_devops__Change_Submission__c sf_devops__Change_Submission__c;
    global sf_devops__Environment__c sf_devops__Environment__c;
    global Boolean sf_devops__Hidden__c;
    global String sf_devops__Message__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Operation_Result__c;
    global sf_devops__Object_Activity__c sf_devops__Parent_Activity__c;
    global sf_devops__Pipeline__c sf_devops__Pipeline__c;
    global String sf_devops__Summary__c;
    global sf_devops__Pipeline_Stage__c sf_devops__Target_Pipeline_Stage__c;
    global sf_devops__Work_Item__c sf_devops__Work_Item__c;

    global sf_devops__Object_Activity__ChangeEvent () 
    {
    }
}