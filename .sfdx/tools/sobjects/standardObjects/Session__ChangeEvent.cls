// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Session__ChangeEvent {
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
    global Campaign Program__c;
    global String Roman__c;
    global Double Session_Number__c;
    global String Title__c;
    global String LFBudgId__c;
    global String Subtitle__c;
    global String Roman_formula__c;
    /* Sum of pages from all session readings
    */
    global Double Total_Pages__c;
    global String Unique_Session_Key__c;
    global Boolean Lecture__c;

    global Session__ChangeEvent () 
    {
    }
}