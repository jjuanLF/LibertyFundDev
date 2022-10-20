// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CMTD__EnhancedRelatedList__mdt {
    global Id Id;
    global String DeveloperName;
    global String MasterLabel;
    global String Language;
    global String NamespacePrefix;
    global String Label;
    global String QualifiedApiName;
    /* Colour for Badge UI Type Override - only accept HEX
    */
    global String CMTD__Colour__c;
    /* Field API Name of the object as specified in "Object API Name" attribute of the CMTD Enhanced Related List component
    */
    global String CMTD__Field_API_Name__c;
    /* Used to display fields in the header section when using Tile display mode.
    */
    global Boolean CMTD__Header__c;
    /* Flag to indicate if the CMT record is used. When this field is checked, the CMT record will be ignored and the field will not be displayed in the component.
    */
    global Boolean CMTD__Inactive__c;
    /* Sequence to display the fields in the component
    */
    global Double CMTD__Order__c;
    /* Related List Name as specified in "Related List Name" attribute of the CMTD Enhanced Related List component
    */
    global String CMTD__Related_List_Name__c;
    /* To enable hyperlink, provide field API Name that contains the Id of the target record. (only support Salesforce record id)
    */
    global String CMTD__Target_API_Name__c;
    /* To override the UI display of the field.
    */
    global String CMTD__UI_Type_Override__c;

    global CMTD__EnhancedRelatedList__mdt () 
    {
    }
}