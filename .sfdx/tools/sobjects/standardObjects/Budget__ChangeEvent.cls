// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Budget__ChangeEvent {
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
    global Campaign Campaign__c;
    global Decimal Amount_Actual__c;
    global Decimal Amount_Budgeted__c;
    global Budget_Class__c Budget_Class__c;
    global String Budget_Status__c;
    /* From the Conference database TYPE field
    */
    global String Type__c;
    global String External_ID__c;

    global Budget__ChangeEvent () 
    {
    }
}