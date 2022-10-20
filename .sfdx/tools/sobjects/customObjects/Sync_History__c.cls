// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Sync_History__c {
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
    global String Batch_Number__c;
    global Datetime End_Date_Time__c;
    global String Error_Msg__c;
    global Datetime Start_Date_Time__c;
    global String Status__c;
    /* The total number of staging records (across all objects) that were errored when processed by Salesforce for this batch (failed attempt to upsert to target records).
    */
    global Double Total_Failed_Conversions__c;
    /* The total number of staging records (across all objects) that were processed by Salesforce for this batch (attempted upsert to target records).
    */
    global Double Total_Records_Converted__c;
    global String Upload_Aborted_By__c;
    global String Upload_Error_s__c;
    global List<AccountStagingTable__c> Account_Staging_Tables__r;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CitationStagingTable__c> Citation_Staging_Table__r;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ConferenceCitationStagingTable__c> Conference_Citation_Staging_Tables__r;
    global List<ContactRequest> ContactRequests;
    global List<ContactStagingTable__c> Contact_Staging_Tables__r;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<EvaluationStagingTable__c> Evaluation_Staging_Tables__r;
    global List<Exception__c> Exceptions__r;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<ProgramMemberStagingTable__c> Program_Member_Staging_Tables__r;
    global List<ProgramStagingTable__c> Program_Staging_Tables__r;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Sync_History__Share> Shares;
    global List<TopicAssignment> TopicAssignments;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;

    global Sync_History__c () 
    {
    }
}