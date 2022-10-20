// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Change_Submission__c {
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
    global sf_devops__Repository__c sf_devops__Repository__r;
    global Id sf_devops__Repository__c;
    global String sf_devops__Comment__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Creation_Result__r;
    global Id sf_devops__Creation_Result__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Inspection_Result__r;
    global Id sf_devops__Inspection_Result__c;
    global String sf_devops__Modified_Remote_Changes__c;
    global Boolean sf_devops__Open_Beta_Migrated__c;
    global String sf_devops__Prior_Remote_Reference__c;
    global String sf_devops__Remote_Reference__c;
    global String sf_devops__Removed_Remote_Changes__c;
    global String sf_devops__Submitted_By_Name__c;
    global User sf_devops__Submitted_By__r;
    global Id sf_devops__Submitted_By__c;
    global Datetime sf_devops__Submitted_On__c;
    global sf_devops__Work_Item__c sf_devops__Work_Item__r;
    global Id sf_devops__Work_Item__c;
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
    global List<sf_devops__Object_Activity__c> sf_devops__Object_Activities__r;
    global List<sf_devops__Remote_Change__c> sf_devops__Changes__r;
    global List<sf_devops__Submit_Component__c> sf_devops__Submit_Components__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;

    global sf_devops__Change_Submission__c () 
    {
    }
}