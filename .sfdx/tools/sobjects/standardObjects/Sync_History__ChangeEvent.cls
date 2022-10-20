// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Sync_History__ChangeEvent {
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
    global String Batch_Number__c;
    global Datetime End_Date_Time__c;
    global String Error_Msg__c;
    global Datetime Start_Date_Time__c;
    global String Status__c;
    /* The total number of staging records (across all objects) that were errored when processed by Salesforce for this batch (failed attempt to upsert to target records).
    */
    global Double Total_Failed_Conversions__c;
    /* The total number of staging records (across all objects) that were processed by Salesforce for this batch (attempted upsert to target records).
    */
    global Double Total_Records_Converted__c;
    global String Upload_Aborted_By__c;
    global String Upload_Error_s__c;

    global Sync_History__ChangeEvent () 
    {
    }
}