// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__Insert_Update__ChangeEvent {
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
    global Loop__DDP__c Loop__DDP__c;
    /* Example: 1 AND (2 OR 3)
    */
    global String Loop__Advanced_Conditions__c;
    /* If checked, the DocGen Package file(s) will be attached to this object (attach type based on delivery method). Checking this field will prevent the DocGen Package from being attached to the originating object unless specified in a Create/Edit Record.
    */
    global Boolean Loop__Attach__c;
    /* Create or Update this record only if...
    */
    global String Loop__Conditions__c;
    /* Run this Create/Edit Record for the selected delivery methods.
    */
    global String Loop__Delivery_Methods__c;
    global String Loop__Description__c;
    global String Loop__Field_Value_Pairs__c;
    /* This number determines the sequence that the Create/Edit Records will occur in.
    */
    global Double Loop__Order__c;
    /* If selected, this Create/Edit Record will be executed at the beginning of the DocGen Package run process.
    */
    global Boolean Loop__Run_at_Beginning__c;
    /* After the record has been created or updated, it will be submitted for approval. This requires an active approval process to already be in place for this object type. See the Salesforce Help site for more info on Approval Processes.
    */
    global Boolean Loop__Submit_for_Approval__c;
    /* If selected, this Create/Edit Record will be executed using an administrator's credentials as specified on the DocGen Admin tab.
    */
    global Boolean Loop__Use_Admin_Credentials__c;

    global Loop__Insert_Update__ChangeEvent () 
    {
    }
}