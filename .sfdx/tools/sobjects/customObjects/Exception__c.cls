// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Exception__c {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
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
    global AccountStagingTable__c Account_Staging_Table__r;
    global Id Account_Staging_Table__c;
    global String Affected_Fields__c;
    global String Affected_Record_Id__c;
    global String Affected_Record_Link__c;
    global Sync_History__c Batch__r;
    global Id Batch__c;
    global CitationStagingTable__c Citation_Staging_Table__r;
    global Id Citation_Staging_Table__c;
    global ConferenceCitationStagingTable__c Conference_Citation_Staging_Table__r;
    global Id Conference_Citation_Staging_Table__c;
    global ContactStagingTable__c Contact_Staging_Table__r;
    global Id Contact_Staging_Table__c;
    global String Error_Message__c;
    global EvaluationStagingTable__c Evaluation_Staging_Table__r;
    global Id Evaluation_Staging_Table__c;
    global String External_Id__c;
    global ProgramMemberStagingTable__c Program_Member_Staging_Table__r;
    global Id Program_Member_Staging_Table__c;
    global ProgramStagingTable__c Program_Staging_Table__r;
    global Id Program_Staging_Table__c;
    global String Source_Database__c;
    global String Stack_Trace__c;
    global String Staging_Record_Link__c;
    global String Status_Code__c;
    global String Type__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<Exception__Share> Shares;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Task> Tasks;
    global List<TopicAssignment> TopicAssignments;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<OutgoingEmail> RelatedTo;
    global List<TaskChangeEvent> What;

    global Exception__c () 
    {
    }
}