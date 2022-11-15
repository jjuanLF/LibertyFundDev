// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Program__c {
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
    global Decimal BudgetAmount__c;
    global Campaign CampaignId__r;
    global Id CampaignId__c;
    global String ConfereeType__c;
    global String ConferenceType__c;
    global Date EndDate__c;
    global String FiscalYear__c;
    global User LFRepId__r;
    global Id LFRepId__c;
    global Double NumberOfSessions__c;
    global Account PartnerId__r;
    global Id PartnerId__c;
    global Contact PartnerRepId__r;
    global Id PartnerRepId__c;
    global String ProgramId__c;
    global String ProgramTitle__c;
    global String ProposalId__c;
    global String Region__c;
    global Campaign RepeatProgramId__r;
    global Id RepeatProgramId__c;
    global String Stage__c;
    global Date StartDate__c;
    global Account VenueId__r;
    global Id VenueId__c;
    global String SubStage__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContactStagingTable__c> ImportedContact__r;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<ProgramAttendee__c> ProgramAttendee__r;
    global List<ProgramChecklist__c> ProgramChecklist__r;
    global List<ProgramCoSponsorTeam__c> ProgramCoSponsorTeam__r;
    global List<ProgramNarrative__c> ProgramNarrative__r;
    global List<ProgramSession__c> Program_Sessions__r;
    global List<ProgramTeam__c> ProgramTeam__r;
    global List<Program__History> Histories;
    global List<Program__Share> Shares;
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

    global Program__c () 
    {
    }
}