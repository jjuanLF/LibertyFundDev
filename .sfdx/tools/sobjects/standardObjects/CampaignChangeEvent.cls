// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CampaignChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global Campaign Parent;
    global Id ParentId;
    global String Type;
    global RecordType RecordType;
    global Id RecordTypeId;
    global String Status;
    global Date StartDate;
    global Date EndDate;
    global Decimal ExpectedRevenue;
    global Decimal BudgetedCost;
    global Decimal ActualCost;
    global Double ExpectedResponse;
    global Double NumberSent;
    global Boolean IsActive;
    global String Description;
    global Integer NumberOfLeads;
    global Integer NumberOfConvertedLeads;
    global Integer NumberOfContacts;
    global Integer NumberOfResponses;
    global Integer NumberOfOpportunities;
    global Integer NumberOfWonOpportunities;
    global Decimal AmountAllOpportunities;
    global Decimal AmountWonOpportunities;
    global Integer HierarchyNumberOfLeads;
    global Integer HierarchyNumberOfConvertedLeads;
    global Integer HierarchyNumberOfContacts;
    global Integer HierarchyNumberOfResponses;
    global Integer HierarchyNumberOfOpportunities;
    global Integer HierarchyNumberOfWonOpportunities;
    global Decimal HierarchyAmountAllOpportunities;
    global Decimal HierarchyAmountWonOpportunities;
    global Double HierarchyNumberSent;
    global Decimal HierarchyExpectedRevenue;
    global Decimal HierarchyBudgetedCost;
    global Decimal HierarchyActualCost;
    global User Owner;
    global Id OwnerId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global RecordType CampaignMemberRecordType;
    global Id CampaignMemberRecordTypeId;
    global Date Board_Approved_Date__c;
    global Date Board_Reviewed_Date__c;
    global String City__c;
    global Account CoSponsor__c;
    global String Conferee_Type__c;
    global String Country__c;
    global String Director_Display__c;
    global String Director__c;
    global String E_number__c;
    global String Fellow_Title__c;
    global Contact Fellow__c;
    /* i.e. 2020-21
    */
    global String Fiscal_Year__c;
    global Boolean Has_Reader__c;
    global String Hotel_Address__c;
    global String Hotel_ID__c;
    global String Hotel_Phone__c;
    global String Hotel_URL__c;
    global Account Hotel__c;
    global Boolean Indianapolis__c;
    global String LFBudgId__c;
    global Boolean LF_Books_Read__c;
    global Contact Planner__c;
    global String Long_Name__c;
    global String ORI_Proposal__c;
    global String PEP__c;
    global Campaign Repeat_Of__c;
    global String Site_City_State_Country__c;
    global String State__c;
    global String Program_Number_Name__c;
    global Decimal Budget_Actual__c;
    global Decimal Budget_Estimated__c;
    global Double Number_of_Sessions__c;
    global Double of_Sessions__c;
    global String Record_Type_Name__c;
    /* Total page count from all sessions/session readings
    */
    global Double Total_Pages__c;
    global String Fellow_Code__c;
    global String Location__c;
    global String Lookup_Reference_Fields__c;
    global String Program_Header__c;
    global String Workflow_Step__c;
    global String Short_Name__c;
    global String Proposal_ID__c;
    global String Fellow_Co_Spon__c;
    global Double LF_Book_Count__c;
    global Contact lfadmin__c;
    global String Budget_Status__c;
    global Double Rank__c;
    global String Conf_Type__c;
    global Boolean Inclusive__c;
    global Boolean Shepherd__c;
    global String CEP__c;
    global String Dir_Report__c;
    global Contact Submitting_Fellow__c;
    global Program_Category__c CategoryPrimary__c;
    global Program_Category__c Category2__c;
    global String Core_Categories__c;
    global String Conference_Dates__c;
    global String Type_Status__c;
    global Boolean IsLFRepOrPlanner__c;
    global Boolean Is_Current_Fiscal_Year__c;
    global Program_Invite_Settings__c Program_Invite_Settings__c;

    global CampaignChangeEvent () 
    {
    }
}