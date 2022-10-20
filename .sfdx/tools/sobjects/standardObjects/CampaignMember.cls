// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CampaignMember {
    global Id Id;
    global Boolean IsDeleted;
    global Campaign Campaign;
    global Id CampaignId;
    global Lead Lead;
    global Id LeadId;
    global Contact Contact;
    global Id ContactId;
    global String Status;
    global Boolean HasResponded;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Date FirstRespondedDate;
    global String Salutation;
    global String Name;
    global String FirstName;
    global String LastName;
    global String Title;
    global String Street;
    global String City;
    global String State;
    global String PostalCode;
    global String Country;
    global String Email;
    global String Phone;
    global String Fax;
    global String MobilePhone;
    global String Description;
    global Boolean DoNotCall;
    global Boolean HasOptedOutOfEmail;
    global Boolean HasOptedOutOfFax;
    global String LeadSource;
    global String CompanyOrAccount;
    global String Type;
    global SObject LeadOrContact;
    global Id LeadOrContactId;
    global SObject LeadOrContactOwner;
    global Id LeadOrContactOwnerId;
    global Date Conference_Start_Date__c;
    global String External_ID__c;
    global String ENumber__c;
    global Evaluation__c Evaluation__r;
    global Id Evaluation__c;
    global Double Group_Code__c;
    global String PID__c;
    global Boolean Participation_Include_Count_Flag__c;
    global String Participation_Type_Name__c;
    global Participation_Type__c Participation_Type__r;
    global Id Participation_Type__c;
    global String Primary_Affiliation_Name__c;
    global String Campaign_Type__c;
    global Boolean Director__c;
    global Boolean Disc_Lead__c;
    global Boolean Discussion_Leader__c;
    global String BudgID__c;
    /* Pending: Not yet added to the Conference database. Success: Added to the Conference database as a suggested conferee. Error: Sync to Conference database failed; see Integration Error field for details.
    */
    global String Integration_Status__c;
    global Double Sort_Order__c;
    global String Suggested_By_Type__c;
    global String Suggested_By__c;
    global String Suggested_Note__c;
    global String View_Link__c;
    global Invitation__c Invitation__r;
    global Id Invitation__c;
    global List<ListEmailIndividualRecipient> ListEmailIndividualRecipients;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<FlowRecordRelation> RelatedRecord;

    global CampaignMember () 
    {
    }
}