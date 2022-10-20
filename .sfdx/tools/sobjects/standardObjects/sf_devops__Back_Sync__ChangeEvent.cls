// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Back_Sync__ChangeEvent {
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
    global sf_devops__Deployment_Result__c sf_devops__Deployment_Result__c;
    global sf_devops__Environment__c sf_devops__Destination_Environment__c;
    global Double sf_devops__End_Revision_Counter__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Operation_Result__c;
    global sf_devops__Pipeline_Stage__c sf_devops__Source_Pipeline_Stage__c;
    global Double sf_devops__Start_Revision_Counter__c;

    global sf_devops__Back_Sync__ChangeEvent () 
    {
    }
}