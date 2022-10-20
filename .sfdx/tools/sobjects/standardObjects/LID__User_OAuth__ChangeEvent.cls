// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class LID__User_OAuth__ChangeEvent {
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
    global Datetime LID__Access_Expiration__c;
    global Boolean LID__Access_Expired__c;
    global String LID__Access_Token__c;
    global Datetime LID__Refresh_Expiration__c;
    global Boolean LID__Refresh_Expired__c;
    global String LID__Refresh_Token__c;
    global Datetime LID__Sales_Access_Expiration__c;
    global Boolean LID__Sales_Access_Expired__c;
    global String LID__Sales_Access_Token__c;
    global User LID__User__c;

    global LID__User_OAuth__ChangeEvent () 
    {
    }
}