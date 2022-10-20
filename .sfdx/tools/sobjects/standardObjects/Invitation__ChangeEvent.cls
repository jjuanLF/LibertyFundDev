// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Invitation__ChangeEvent {
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
    global String Drive_ID__c;
    global String Envelope_ID__c;
    global String Status__c;
    global String Drive_Link__c;
    global Campaign Program__c;
    global Contact Person__c;
    global Datetime Sent__c;
    global Datetime Delivered__c;
    global Datetime Signed__c;
    global Datetime Completed__c;
    global String VoidReason__c;

    global Invitation__ChangeEvent () 
    {
    }
}