// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__PDF_Stamp__c {
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
    global String Loop__Background_Color__c;
    /* Number of pixels of padding to add of the Background Color behind the text.
    */
    global Double Loop__Background_Padding__c;
    /* Merged - stamp entire merged PDF as a whole. All - stamp all PDFs individually. Select individual files to stamp them separately.
    */
    global String Loop__DDP_Files__c;
    global String Loop__Delivery_Methods__c;
    global String Loop__Description__c;
    global Double Loop__FontSize__c;
    global String Loop__Font__c;
    global String Loop__HAlign__c;
    global Double Loop__Height__c;
    /* Percentage of opacity (default is 100% opaque)
    */
    global Double Loop__Opacity__c;
    global Double Loop__Order__c;
    /* Specify the pages to be stamped. Use a dash to indicate a range, use commas to separate pages or ranges, or enter Odd or Even (e.g. 1-5,8,10-12). A blank value will stamp all pages.
    */
    global String Loop__Pages__c;
    /* The 6 character RGB code for the text color of the stamp. (Default: black)
    */
    global String Loop__RGB_Color__c;
    /* Number in degrees (0 to 360)
    */
    global Double Loop__Rotation__c;
    global String Loop__Scale_By__c;
    /* Text to stamp onto the PDF. Use [[page]] for the current page number; use [[total pages]] for the total number of pages; [[bookmark]], [[sectionName]], [[filename]]. Use the field tagger to include other dynamic tags. (e.g. [[page]] of [[total pages]])
    */
    global String Loop__Stamp_Text__c;
    global String Loop__Style__c;
    global String Loop__Type__c;
    global String Loop__VAlign__c;
    global Double Loop__Width__c;
    /* Offset from horizontal alignment in pixels. Positive numbers move the stamp right and negative numbers move the stamp left.
    */
    global Double Loop__XOffset__c;
    /* Offset from vertical alignment in pixels. Positive numbers move the stamp up and negative numbers move the stamp down.
    */
    global Double Loop__YOffset__c;
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

    global Loop__PDF_Stamp__c () 
    {
    }
}