// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__Form_Field__ChangeEvent {
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
    global String Loop__Default_Value__c;
    /* The message displayed when the input value does not match the field validation.
    */
    global String Loop__Error_Message__c;
    global Loop__Form_Step__c Loop__Form_Step__c;
    global String Loop__Help_Text__c;
    global Boolean Loop__Ignored__c;
    global String Loop__List_Values__c;
    global Double Loop__Order__c;
    global String Loop__SfDefault_Value__c;
    global String Loop__Tag__c;
    global String Loop__Type__c;
    /* This can be any regular expression you wish to use to validate this field. See http://regexlib.com/CheatSheet.aspx
    */
    global String Loop__Validation__c;
    global String Loop__TagView__c;

    global Loop__Form_Field__ChangeEvent () 
    {
    }
}