// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Branch__ChangeEvent {
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
    global String sf_devops__Ignore_Rules__c;
    /* The name of the branch.
    */
    global String sf_devops__Name__c;
    /* The remote reference on the source branch that our branch was created from.
    */
    global String sf_devops__Parent_Remote_Reference__c;
    /* The latest remote reference on our branch.
    */
    global String sf_devops__Remote_Reference__c;
    global sf_devops__Repository__c sf_devops__Repository__c;

    global sf_devops__Branch__ChangeEvent () 
    {
    }
}