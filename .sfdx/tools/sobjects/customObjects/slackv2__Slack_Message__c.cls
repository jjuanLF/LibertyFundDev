// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class slackv2__Slack_Message__c {
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
    global Account slackv2__Account__r;
    global Id slackv2__Account__c;
    global Case slackv2__Case__r;
    global Id slackv2__Case__c;
    global String slackv2__Channel_Id__c;
    global String slackv2__Channel_Name__c;
    global String slackv2__Channel_Type__c;
    global Contact slackv2__Contact__r;
    global Id slackv2__Contact__c;
    global String slackv2__Content__c;
    global Lead slackv2__Lead__r;
    global Id slackv2__Lead__c;
    global String slackv2__Message_Url__c;
    global Opportunity slackv2__Opportunity__r;
    global Id slackv2__Opportunity__c;
    global String slackv2__Record_Id__c;
    global String slackv2__Team_Id__c;
    global Datetime slackv2__Time_Stamp__c;
    global String slackv2__User_Image_Url__c;
    global String slackv2__User_Name__c;
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
    global List<slackv2__Slack_Message__Share> Shares;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;

    global slackv2__Slack_Message__c () 
    {
    }
}