// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Integration_Staging_Table_Field_Mapping__mdt {
    global Id Id;
    global String DeveloperName;
    global String MasterLabel;
    global String Language;
    global String NamespacePrefix;
    global String Label;
    global String QualifiedApiName;
    /* Provide the API Name of the field in the queried table that contains the external Id
    */
    global String Query_Field__c;
    /* Provide the API Name of the object to query for the provided external Id
    */
    global String Query_Object__c;
    /* Provide the API Name of the field on the staging table where the data originates
    */
    global String Source_Field__c;
    /* Provide the API Name of the staging table where the data originates
    */
    global String Source_Object__c;
    /* Provide the API Name of the field on the object where the data should be inserted
    */
    global String Target_Field__c;
    /* Provide the API Name of the table where the data should be inserted
    */
    global String Target_Object__c;
    /* If a value needs to be truncated during conversion, provide the truncated character limit here.  Do not apply to reference field mappings (that use a query object & field).  Apply to text/string values ONLY.
    */
    global Double Truncation_Limit__c;

    global Integration_Staging_Table_Field_Mapping__mdt () 
    {
    }
}