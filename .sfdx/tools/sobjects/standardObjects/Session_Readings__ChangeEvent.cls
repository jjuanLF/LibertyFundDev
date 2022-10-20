// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Session_Readings__ChangeEvent {
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
    global Session__c Session__c;
    global String BibliographyId__c;
    global Citation__c Citation__c;
    global String Publication_Title__c;
    global Double Page_Count__c;
    global String Pages__c;
    global Conference_Citation__c Conference_Citation__c;
    /* Conference database reading_id
    */
    global String Reading_ID__c;
    global String Annotation__c;
    global Double Sort_Order__c;
    global Boolean Exclude_Flag__c;
    global String Copy_Purchase__c;
    global String Credit_Line__c;
    global String Notes__c;
    global String Chapter__c;

    global Session_Readings__ChangeEvent () 
    {
    }
}