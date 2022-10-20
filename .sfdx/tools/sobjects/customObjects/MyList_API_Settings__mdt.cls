// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class MyList_API_Settings__mdt {
    global Id Id;
    global String DeveloperName;
    global String MasterLabel;
    global String Language;
    global String NamespacePrefix;
    global String Label;
    global String QualifiedApiName;
    global String Bearer_Token__c;
    /* Comma-separated list of email addresses to include in API callout
    */
    global String Debug_Emails__c;
    /* Enables the logging of every outbound callout
    */
    global Boolean Enable_Logging__c;
    global String Endpoint_URL__c;

    global MyList_API_Settings__mdt () 
    {
    }
}