// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__LoopSettings__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global SObject SetupOwner;
    global Id SetupOwnerId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    /* Decryption is currently only supported with CipherCloud. Contact Nintex to enable this for your organization.
    */
    global Boolean Loop__Decryption_Allowed__c;
    /* Enter a semi-colon delimited list of DocuSign Account Ids that this organization, profile, or user can chose from. (Limit 6 Account Ids)
    */
    global String Loop__DocuSign_Account_Ids__c;
    /* Enter a semi-colon delimited list of Account Names that correspond to the DocuSign Account Ids. (Limit 6 Account Names)
    */
    global String Loop__DocuSign_Account_Names__c;
    /* Enter a semi-colon delimited list of DocuSign User Ids that correspond to the DocuSign Account Ids. (Limit 6 User Ids)
    */
    global String Loop__DocuSign_User_Ids__c;
    global Boolean Loop__Job_Queue_Status_Enabled__c;
    /* Valid options are "Upload" and "Salesforce Files Sync". (Do not include the quotes.)
    */
    global String Loop__Pause_to_Edit_Type__c;
    global Boolean Loop__Sandbox__c;
    global Boolean Loop__Show_DDP_Wizard_Message__c;
    global Boolean Loop__Show_Edit_Form_Message__c;
    global Boolean Loop__Store_Attachments_As_Salesforce_Files__c;
    global String Loop__Veeva_Vault_Subdomain__c;

    global Loop__LoopSettings__ChangeEvent () 
    {
    }
}