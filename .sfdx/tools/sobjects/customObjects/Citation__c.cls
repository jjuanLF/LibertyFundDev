// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Citation__c {
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
    global Date LastActivityDate;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String Author__c;
    global String Biblio__c;
    global String BiblioId__c;
    /* Indicates that a Citation record is missing the shortened form of its URL
    */
    global Boolean Short_URL_Needed__c;
    global String Copy_Purchase__c;
    global String Credit_Line__c;
    global Boolean LF_Book__c;
    global String Notes__c;
    global String Publication_Date__c;
    global String Publication_Number__c;
    global String Publication_Publisher__c;
    global String Publication_Title__c;
    global String Publication_Type__c;
    global String Publication_URL__c;
    global String Citation__c;
    global String Full_URL__c;
    global Citation__c Parent_Citation__r;
    global Id Parent_Citation__c;
    global String ISBN__c;
    global String Citation_trunc__c;
    global String Citation_Markdown__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Citation_Author__c> Citation_Authors__r;
    global List<Citation__History> Histories;
    global List<Citation__Share> Shares;
    global List<Citation__c> Citations__r;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<Conference_Citation__c> Conference_Citations__r;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<Documents__c> Documents__r;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<ProgramSessionReading__c> ProgramSessionReading__r;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Session_Readings__c> Session_Readings__r;
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

    global Citation__c () 
    {
    }
}