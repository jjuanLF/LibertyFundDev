// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Environment__c {
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
    global sf_devops__Project__c sf_devops__Project__r;
    global Id sf_devops__Project__c;
    global Boolean sf_devops__Can_Track_Changes__c;
    global Double sf_devops__Last_Revision_Counter__c;
    global String sf_devops__Named_Credential__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Operation_Result__r;
    global Id sf_devops__Operation_Result__c;
    global Boolean sf_devops__Test_Environment__c;
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
    global List<sf_devops__Back_Sync__c> sf_devops__Destination_Back_Syncs__r;
    global List<sf_devops__Change_Bundle_Install__c> sf_devops__Change_Bundle_Installs__r;
    global List<sf_devops__Object_Activity__c> sf_devops__Object_Activities__r;
    global List<sf_devops__Pipeline_Stage__c> sf_devops__Pipeline_Stages__r;
    global List<sf_devops__Remote_Change__c> sf_devops__Remote_Changes__r;
    global List<sf_devops__Work_Item__c> sf_devops__Work_Items__r;
    global List<sf_devops__Work_Item__c> sf_devops__Work_Items_Environments__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;

    global sf_devops__Environment__c () 
    {
    }
}