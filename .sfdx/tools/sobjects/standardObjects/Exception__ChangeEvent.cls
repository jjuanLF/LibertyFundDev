// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Exception__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global User Owner;
    global Id OwnerId;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global AccountStagingTable__c Account_Staging_Table__c;
    global String Affected_Fields__c;
    global String Affected_Record_Id__c;
    global String Affected_Record_Link__c;
    global Sync_History__c Batch__c;
    global CitationStagingTable__c Citation_Staging_Table__c;
    global ConferenceCitationStagingTable__c Conference_Citation_Staging_Table__c;
    global ContactStagingTable__c Contact_Staging_Table__c;
    global String Error_Message__c;
    global EvaluationStagingTable__c Evaluation_Staging_Table__c;
    global String External_Id__c;
    global ProgramMemberStagingTable__c Program_Member_Staging_Table__c;
    global ProgramStagingTable__c Program_Staging_Table__c;
    global String Source_Database__c;
    global String Stack_Trace__c;
    global String Staging_Record_Link__c;
    global String Status_Code__c;
    global String Type__c;

    global Exception__ChangeEvent () 
    {
    }
}