// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class EvaluationStagingTable__ChangeEvent {
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
    global String BudgID__c;
    global String Evaluation_Notes__c;
    global String Evaluation_Rating__c;
    global String External_ID__c;
    global String PID__c;
    global String Participation_Type_Name__c;
    global Sync_History__c Staging_Batch__c;

    global EvaluationStagingTable__ChangeEvent () 
    {
    }
}