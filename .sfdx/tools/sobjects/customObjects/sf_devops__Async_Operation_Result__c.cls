// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Async_Operation_Result__c {
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
    global String sf_devops__Error_Details__c;
    global String sf_devops__Log_Id__c;
    global String sf_devops__Message__c;
    global String sf_devops__Operation__c;
    global String sf_devops__Remote_Commands__c;
    global String sf_devops__Status__c;
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
    global List<sf_devops__Async_Operation_Result__Share> Shares;
    global List<sf_devops__Back_Sync__c> sf_devops__Back_Syncs__r;
    global List<sf_devops__Change_Bundle_Install__c> sf_devops__Change_Bundle_Installs__r;
    global List<sf_devops__Change_Submission__c> sf_devops__Change_Submissions__r;
    global List<sf_devops__Change_Submission__c> sf_devops__Inspected_Change_Submissions__r;
    global List<sf_devops__Deployment_Result__c> sf_devops__Deployment_Results__r;
    global List<sf_devops__Environment__c> sf_devops__Environments__r;
    global List<sf_devops__Object_Activity__c> sf_devops__Object_Activities__r;
    global List<sf_devops__Pipeline_Stage__c> sf_devops__Pipeline_Stages__r;
    global List<sf_devops__Vcs_Event__c> sf_devops__VCS_Events__r;
    global List<sf_devops__Work_Item_Promote__c> sf_devops__Work_Item_Promote_Rebases__r;
    global List<sf_devops__Work_Item_Promote__c> sf_devops__Work_Item_Promotes__r;
    global List<sf_devops__Work_Item__c> sf_devops__Work_Items__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;

    global sf_devops__Async_Operation_Result__c () 
    {
    }
}