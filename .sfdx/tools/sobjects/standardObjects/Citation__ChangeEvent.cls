// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Citation__ChangeEvent {
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
    global String Author__c;
    global String Biblio__c;
    global String BiblioId__c;
    /* Indicates that a Citation record is missing the shortened form of its URL
    */
    global Boolean Short_URL_Needed__c;
    global String Copy_Purchase__c;
    global String Credit_Line__c;
    global Boolean LF_Book__c;
    global String Notes__c;
    global String Publication_Date__c;
    global String Publication_Number__c;
    global String Publication_Publisher__c;
    global String Publication_Title__c;
    global String Publication_Type__c;
    global String Publication_URL__c;
    global String Citation__c;
    global String Full_URL__c;
    global Citation__c Parent_Citation__c;
    global String ISBN__c;
    global String Citation_trunc__c;
    global String Citation_Markdown__c;

    global Citation__ChangeEvent () 
    {
    }
}