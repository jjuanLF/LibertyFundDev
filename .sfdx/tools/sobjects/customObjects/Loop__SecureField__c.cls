// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__SecureField__c {
    global Id Id;
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
    global Loop__dsRecipient__c Loop__Recipient__r;
    global Id Loop__Recipient__c;
    /* If this option is checked, data entered in this field during the signing process will not be visible to any of the signers or the sender.
    */
    global Boolean Loop__Conceal__c;
    global String Loop__Font__c;
    global String Loop__GroupName__c;
    /* in pixels
    */
    global Double Loop__Height__c;
    /* This is a semicolon delimited list of pick list items.
    */
    global String Loop__ListItems__c;
    global Boolean Loop__Locked__c;
    global Boolean Loop__Required__c;
    global Boolean Loop__Selected__c;
    global String Loop__ToolTip__c;
    /* This applies a standard validation pattern to the secure field.
    */
    global String Loop__Type__c;
    global String Loop__Update_Field__c;
    /* This error message will be displayed if the input does not match the validation pattern.
    */
    global String Loop__ValidationMessage__c;
    /* Insert a Regular Expression (RegEx) pattern to validate the input. Learn more about Regular Expressions at www.regexlib.com.
    */
    global String Loop__ValidationPattern__c;
    /* This can be made dynamic by using tags from the Field Tagger.
    */
    global String Loop__Value__c;
    /* in pixels
    */
    global Double Loop__Width__c;
    /* Positive X Offset values move the tab right on the page.
    */
    global Double Loop__X_Offset__c;
    /* Positive Y Offset values move the tab down on the page.
    */
    global Double Loop__Y_Offset__c;
    /* The value of the parent field will determine whether this field appears while the recipient is signing.
    */
    global Loop__SecureField__c Loop__dsParentField__r;
    /* The value of the parent field will determine whether this field appears while the recipient is signing.
    */
    global Id Loop__dsParentField__c;
    /* If the parent field equals this value, this secure field will be visible while the recipient is signing.
    */
    global String Loop__dsParentValue__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Loop__SecureField__c> Loop__Conditional_Fields__r;
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

    global Loop__SecureField__c () 
    {
    }
}