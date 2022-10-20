// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Work_Item__ChangeEvent {
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
    global sf_devops__Project__c sf_devops__Project__c;
    global User sf_devops__Assigned_To__c;
    global String sf_devops__Branch_Name__c;
    global String sf_devops__Branch_Parent_Remote_Reference__c;
    global String sf_devops__Branch_Remote_Reference__c;
    global sf_devops__Branch__c sf_devops__Branch__c;
    global sf_devops__Change_Bundle__c sf_devops__Change_Bundle__c;
    /* Managed by the DevOps Center, this field indicates that a Work Item has finished being used for active development or promotion.
    */
    global String sf_devops__Concluded__c;
    global String sf_devops__Description__c;
    global User sf_devops__Development_Approved_By__c;
    global Boolean sf_devops__Development_Approved__c;
    global sf_devops__Environment__c sf_devops__Environment__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Operation_Status__c;
    global sf_devops__Environment__c sf_devops__Promoted_From_Environment__c;
    /* Managed by the DevOps Center, when this Work Item record moves into a promoted state, this value will be updated to true automatically.
    */
    global Boolean sf_devops__Promoted__c;
    global String sf_devops__Review_Remote_Reference__c;
    global String sf_devops__Subject__c;
    /* The environment in which this Work Item record was developed.
    */
    global String sf_devops__Development_Environment__c;
    /* The current state of this Work Item record.
    */
    global String sf_devops__State__c;

    global sf_devops__Work_Item__ChangeEvent () 
    {
    }
}