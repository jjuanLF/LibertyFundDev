// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class PID_History__ChangeEvent {
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
    global Contact Contact__c;
    /* Indicates that this PID record contains the PID value currently on the related Contact record
    */
    global Boolean IsMaster__c;
    /* Indicates that this PID is no longer the current PID value on the related Contact but contains a historical PID value inherited from contact merges
    */
    global Boolean IsMerged__c;
    global Datetime Last_Merged_Date__c;
    global String PID__c;
    global Boolean Same_Source_DB_as_Master__c;
    /* Indicates the legacy database where this PID can be found
    */
    global String Source_Database__c;

    global PID_History__ChangeEvent () 
    {
    }
}