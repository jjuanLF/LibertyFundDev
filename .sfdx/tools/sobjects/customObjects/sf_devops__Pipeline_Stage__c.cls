// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Pipeline_Stage__c {
    global Id Id;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global sf_devops__Pipeline__c sf_devops__Pipeline__r;
    global Id sf_devops__Pipeline__c;
    global String sf_devops__Branch_Name__c;
    global String sf_devops__Branch_Remote_Reference__c;
    /* The branch in the VCS that this stage is associated with.
    */
    global sf_devops__Branch__c sf_devops__Branch__r;
    /* The branch in the VCS that this stage is associated with.
    */
    global Id sf_devops__Branch__c;
    global sf_devops__Environment__c sf_devops__Environment__r;
    global Id sf_devops__Environment__c;
    global sf_devops__Pipeline_Stage__c sf_devops__Next_Stage__r;
    global Id sf_devops__Next_Stage__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Operation_Status__r;
    global Id sf_devops__Operation_Status__c;
    global String sf_devops__Promote_Review_Remote_Reference__c;
    global Boolean sf_devops__Versioned__c;
    global Boolean sf_devops__Prerelease__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<TopicAssignment> TopicAssignments;
    global List<sf_devops__Back_Sync__c> sf_devops__Source_Back_Syncs__r;
    global List<sf_devops__Object_Activity__c> sf_devops__Object_Activities__r;
    global List<sf_devops__Pipeline_Stage__c> sf_devops__Pipeline_Stages__r;
    global List<sf_devops__Vcs_Event__c> sf_devops__VCS_Events__r;
    global List<sf_devops__Work_Item_Promote__c> sf_devops__Work_Item_Promotes__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;

    global sf_devops__Pipeline_Stage__c () 
    {
    }
}