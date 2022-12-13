// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__Related_Object__ChangeEvent {
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
    global String Loop__Advanced_Filter_Conditions__c;
    /* This field applies when using line items and determines whether rows, tables, or sections should be duplicated for each child record.
    */
    global String Loop__Copy_Type__c;
    /* If checked, this specifies that you want the table(s) for this object to be deleted if there are no records in the list.
    */
    global Boolean Loop__Delete_Table__c;
    global String Loop__Filter_Conditions__c;
    global String Loop__Group_By_Fields__c;
    global String Loop__Group_By_SortOrders__c;
    global String Loop__Hierarchy_Field__c;
    global String Loop__Hierarchy_Node_Type_Field__c;
    global Double Loop__Index__c;
    /* This field specifies the order of the related objects.
    */
    global String Loop__Order_By__c;
    /* This is used to identify the correct Child-Parent relationship. If there are multiple lookup / master-detail fields that can determine this Child-Parent relationship, select the appropriate one for the necessary data.
    */
    global String Loop__Parent_Object_Field__c;
    /* This is the API Name of the standard or custom object that is the parent of this related object.
    */
    global String Loop__Parent_Object__c;
    global Loop__Related_Object__c Loop__Parent_Relationship__c;
    /* How many records should be included? Leave blank to include all records. If the Copy Type is Hierarchy, this will limit the number of levels instead of records.
    */
    global Double Loop__Record_Limit__c;
    /* Use this field to distinguish between two or more of the same related object. The value entered here will replace the object name in all merge tags. Salesforce Field Name validation rules apply.
    */
    global String Loop__Related_Object_Alias__c;
    global String Loop__SOQL__c;
    global String Loop__Parent__c;

    global Loop__Related_Object__ChangeEvent () 
    {
    }
}