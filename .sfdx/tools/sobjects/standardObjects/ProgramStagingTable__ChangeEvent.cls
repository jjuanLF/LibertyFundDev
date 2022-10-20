// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ProgramStagingTable__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global User Owner;
    global Id OwnerId;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global String Assistant__c;
    global Date Board_Approved_Date__c;
    global Date Board_Reviewed_Date__c;
    global String Budget_Status__c;
    global Double Budgeted_Cost_in_Program__c;
    global String CEP__c;
    global String Conf_Type__c;
    global String Conferee_Type__c;
    global String Conference_ID__c;
    global String Cosponsor__c;
    global String Dir_Report__c;
    global Date End_Date__c;
    global String Fellow__c;
    global String Fiscal_Year__c;
    global Boolean Has_Reader__c;
    global Boolean Hotel_Meals_Inclusive__c;
    global String Hotel__c;
    global Boolean Indianapolis__c;
    global String LFBudgId__c;
    global Boolean LF_Books_Read__c;
    global String Location__c;
    global String ORI_Proposal__c;
    global String PEP_ID__c;
    global String Program_Short_Name__c;
    global String Program_Source__c;
    global String Program_Title_Long__c;
    global String Proposal_ID__c;
    global Double Rank__c;
    /* Conference (Core): 0124S0000004UzKQAU
Co-Sponsor Conference: 0124S0000004UzJQAU
Proposal: 0124S0000004UzLQAU (Core Only)
    */
    global String Record_Type_Id__c;
    global String Repeat_Of__c;
    global Boolean Shepherd__c;
    global Sync_History__c Staging_Batch__c;
    global Date Start_Date__c;
    global String Status__c;
    global String Submitting_Fellow__c;

    global ProgramStagingTable__ChangeEvent () 
    {
    }
}