// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__Form_Field__c {
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
    global Loop__DDP__c Loop__DDP__r;
    global Id Loop__DDP__c;
    global String Loop__Default_Value__c;
    /* The message displayed when the input value does not match the field validation.
    */
    global String Loop__Error_Message__c;
    global Loop__Form_Step__c Loop__Form_Step__r;
    global Id Loop__Form_Step__c;
    global String Loop__Help_Text__c;
    global Boolean Loop__Ignored__c;
    global String Loop__List_Values__c;
    global Double Loop__Order__c;
    global String Loop__SfDefault_Value__c;
    global String Loop__Tag__c;
    global String Loop__Type__c;
    /* This can be any regular expression you wish to use to validate this field. See http://regexlib.com/CheatSheet.aspx
    */
    global String Loop__Validation__c;
    global String Loop__TagView__c;
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
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;

    global Loop__Form_Field__c () 
    {
    }
}