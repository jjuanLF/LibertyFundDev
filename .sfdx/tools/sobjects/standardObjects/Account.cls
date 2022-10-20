// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Account {
    global Id Id;
    global Boolean IsDeleted;
    global Account MasterRecord;
    global Id MasterRecordId;
    global String Name;
    global String Type;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Account Parent;
    global Id ParentId;
    global String BillingStreet;
    global String BillingCity;
    global String BillingState;
    global String BillingPostalCode;
    global String BillingCountry;
    global Double BillingLatitude;
    global Double BillingLongitude;
    global String BillingGeocodeAccuracy;
    global Address BillingAddress;
    global String ShippingStreet;
    global String ShippingCity;
    global String ShippingState;
    global String ShippingPostalCode;
    global String ShippingCountry;
    global Double ShippingLatitude;
    global Double ShippingLongitude;
    global String ShippingGeocodeAccuracy;
    global Address ShippingAddress;
    global String Phone;
    global String Fax;
    global String AccountNumber;
    global String Website;
    global String PhotoUrl;
    global String Sic;
    global String Industry;
    global Decimal AnnualRevenue;
    global Integer NumberOfEmployees;
    global String Ownership;
    global String TickerSymbol;
    global String Description;
    global String Rating;
    global String Site;
    global User Owner;
    global Id OwnerId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Date LastActivityDate;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String Jigsaw;
    global String JigsawCompanyId;
    global String AccountSource;
    global String SicDesc;
    global String Billing_Contact_Email__c;
    global String Billing_Contact__c;
    global Boolean Billing_Same_as_Shipping__c;
    global String Hotel_URL__c;
    /* AcctCode from Liberty Fund Conference database
    */
    global String LF_Account_Code__c;
    /* ID from Liberty Fund Conference database
    */
    global String LF_Vendor_ID__c;
    global String LF_Vendor_Number__c;
    global String Org_Desc__c;
    global String Org_Type__c;
    global String Vendor_Contact_Cell__c;
    global String Vendor_Contact_Email__c;
    global String Vendor_Contact__c;
    global String Billing_Contact_Phone__c;
    global String Billing_Contact_FAX__c;
    global String Shipping_Address_Display__c;
    global String Affiliation_Name__c;
    global String LID__LinkedIn_Company_Id__c;
    global List<Account> ChildAccounts;
    global List<AccountContactRelation> AccountContactRelations;
    global List<AccountContactRole> AccountContactRoles;
    global List<AccountFeed> Feeds;
    global List<AccountHistory> Histories;
    global List<AccountPartner> AccountPartnersFrom;
    global List<AccountPartner> AccountPartnersTo;
    global List<AccountShare> Shares;
    global List<ActivityHistory> ActivityHistories;
    global List<Asset> Assets;
    global List<Asset> ProvidedAssets;
    global List<Asset> ServicedAssets;
    global List<AssociatedLocation> AssociatedLocations;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Campaign> Campaigns1__r;
    global List<Campaign> Campaigns2__r;
    global List<Case> Cases;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<Contact> Contacts;
    global List<Contact> Contacts__r;
    global List<Contact> People__r;
    global List<Contact> Peoples__r;
    global List<ContactPointEmail> ContactPointEmails;
    global List<ContactPointPhone> ContactPointPhones;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<Contract> Contracts;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<Opportunity> Opportunities;
    global List<OpportunityPartner> OpportunityPartnersTo;
    global List<Order> Orders;
    global List<Partner> PartnersFrom;
    global List<Partner> PartnersTo;
    global List<Payment__c> Payments__r;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<SocialPersona> Personas;
    global List<SocialPost> Posts;
    global List<Task> Tasks;
    global List<TopicAssignment> TopicAssignments;
    global List<User> Users;
    global List<slackv2__Slack_Message__c> slackv2__Slack_Messages__r;
    global List<AccountChangeEvent> Parent;
    global List<AccountContactRoleChangeEvent> Account;
    global List<AssetChangeEvent> AssetProvidedBy;
    global List<AssetChangeEvent> AssetServicedBy;
    global List<CampaignMember> LeadOrContact;
    global List<CaseChangeEvent> Account;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<ContractChangeEvent> Account;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<Lead> ConvertedAccount;
    global List<OpportunityChangeEvent> Account;
    global List<TaskChangeEvent> What;
    global List<UserChangeEvent> Account;
    global List<UserRole> PortalAccount;

    global Account () 
    {
    }
}