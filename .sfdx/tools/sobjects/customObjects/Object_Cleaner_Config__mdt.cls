// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Object_Cleaner_Config__mdt {
    global Id Id;
    global String DeveloperName;
    global String MasterLabel;
    global String Language;
    global String NamespacePrefix;
    global String Label;
    global String QualifiedApiName;
    /* Object type of record to be deleted.
    */
    global String Object_Type__c;
    /* Order that the object will be processed.
    */
    global Double Order__c;
    /* Number of days to retain records
    */
    global Double Record_Retention_Days__c;
    /* This field is used for package deployment to indicate the record is used as part of an apex unit test. It should not be changed for any record, and should remain unchecked.
    */
    global Boolean Unit_Test__c;
    /* Date or Date/Time field to delete records once retention period has passed.
    */
    global String Object_Field__c;

    global Object_Cleaner_Config__mdt () 
    {
    }
}