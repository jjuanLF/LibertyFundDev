// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__DDP_File__ChangeEvent {
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
    global Boolean Loop__Advanced_Optional__c;
    global String Loop__Advanced_Section__c;
    global String Loop__Bookmark__c;
    global String Loop__Compare_Field__c;
    global String Loop__Compare_Type__c;
    global String Loop__Compare_Value__c;
    global String Loop__Description__c;
    global String Loop__Document_ID__c;
    global String Loop__Email_As__c;
    /* Example: Sheet1!A:B; Sheet1!2:3; Sheet2!1:4; Sheet Three!A:A
    */
    global String Loop__Excel_Print_Titles__c;
    global String Loop__Excel_Sheets_Option__c;
    /* This is a comma delimited list of Excel Sheet names to include in the output of this file.
    */
    global String Loop__Excel_Sheets__c;
    /* This is a JSON list of operations and their arguments to be performed on this file. Contact Nintex for more information on this feature.
    */
    global String Loop__File_Operations__c;
    global Double Loop__First_Page__c;
    global Double Loop__Last_Page__c;
    global String Loop__Long_Name__c;
    global String Loop__Merge_with_Previous__c;
    global Boolean Loop__Optional__c;
    global Double Loop__Order__c;
    global Boolean Loop__Pause_to_Edit__c;
    global String Loop__ReportIds__c;
    global String Loop__Section_Label__c;
    /* Only use this option if your document is static, i.e. there is no data being merged into this document.
    */
    global Boolean Loop__Skip_Processing__c;
    /* If checked, this file can be re-ordered with the previous file by the user on the DocGen Package selection page.
    */
    global Boolean Loop__Sort_with_Previous__c;
    global String Loop__Type2__c;
    global String Loop__Type__c;
    global String Loop__Vf_Parameters__c;
    global String Loop__Visualforce_Content_Output_Type__c;

    global Loop__DDP_File__ChangeEvent () 
    {
    }
}