// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ContactStagingTable__c {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global Boolean Active_Fellow__c;
    global String Affiliation_Name__c;
    global String Affiliation_Title__c;
    global Double Conferences_Attended_Past_Year__c;
    global String Correspondence_Email__c;
    global String CosponsorPID__c;
    global Double Count_as_Director__c;
    global Double Count_as_Discussion_Leader__c;
    global Boolean Deceased__c;
    global String Email01__c;
    global String Email02__c;
    global String Email03__c;
    global String Fellow_Code__c;
    global Date First_Conference_Date__c;
    global String First_Conference__c;
    global Date First_DL_Date__c;
    global Date First_Director_Date__c;
    global String First_Name__c;
    global Double Future_Conferences__c;
    global String Intacct_Vendor_ID__c;
    global String LFPID__c;
    global String Last_Name__c;
    global String Middle__c;
    global String Person_Type__c;
    global String Primary_Expertise__c;
    global String Public_Email__c;
    /* Conferee: 0124S0000004UzMQAU
    */
    global String Record_Type_Id__c;
    global String Salutation__c;
    global Sync_History__c Staging_Batch__r;
    global Id Staging_Batch__c;
    global String URL__c;
    global String Display_Name__c;
    global String Assistant_Name__c;
    global String Assistant_Phone__c;
    global String Assistant_Email__c;
    global String Address_Instructions__c;
    global String FullName__c;
    global Contact MergeContactId__r;
    global Id MergeContactId__c;
    global String Mobile__c;
    global String Phone__c;
    global String MergeFields__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContactStagingTable__Share> Shares;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Exception__c> Exceptions__r;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<TopicAssignment> TopicAssignments;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;

    global ContactStagingTable__c () 
    {
    }
}