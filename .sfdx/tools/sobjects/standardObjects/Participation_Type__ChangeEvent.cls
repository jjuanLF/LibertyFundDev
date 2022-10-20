// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Participation_Type__ChangeEvent {
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
    global String Description__c;
    /* Indicates whether this participation type implies a Discussion Leader
    */
    global Boolean Discussion_Leader_Flag__c;
    global Double Group_Code__c;
    /* Include in conference participant count
    */
    global Boolean Include_Count_Flag__c;
    global Boolean Leadership_Flag__c;
    global Boolean Liberty_Fund_Flag__c;
    global Double Sort_Order__c;
    global String ExternalID__c;
    global Double LFObserverType__c;

    global Participation_Type__ChangeEvent () 
    {
    }
}