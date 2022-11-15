// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class TMap_Data__c {
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
    global String Academia__c;
    global Double Boost_Score__c;
    global String Business__c;
    global String Candidate_Email__c;
    global String Candidate_Name__c;
    global String College_University__c;
    global String Company_Organization__c;
    global Double Conference_Quality_Score__c;
    global Contact Contact__r;
    global Id Contact__c;
    global String Current_City__c;
    global String Current_Country__c;
    global String Current_Industry__c;
    global String Current_Location__c;
    global String Current_Organization__c;
    global String Current_State__c;
    global Double Degree_Boost__c;
    global Double Doctorate_Degree_s__c;
    global Double Employment_History_Boost__c;
    global Double Experience_Boost__c;
    global String Field_of_Study__c;
    global String Highest_Degree_Earned__c;
    global String Historical_College_University__c;
    global String Historical_Degree__c;
    global String Historical_Field_of_Study__c;
    global Double Industry_Boost__c;
    global String Law_Policy__c;
    global Lead Lead__r;
    global Id Lead__c;
    global String LinkedIn_URL__c;
    global Double Master_Degree_s__c;
    global String Non_Profit__c;
    global String Press_Media__c;
    global Double Publications_Boost__c;
    global String Publications__c;
    global Double Social_Media_Likes_Depth__c;
    global String Social_Media_Likes__c;
    global String TMap_Candidate_ID__c;
    global Double TMap_Preliminary_Relevance_Score__c;
    global Double TMap_Static_S__c;
    global Double Title_Boost__c;
    global String Title__c;
    global Double Years_of_Experience__c;
    global String highlight_experience_companyName__c;
    global String source_profilePlace_city__c;
    global String source_profilePlace_state_abbreviation__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
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
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<TMap_Data__History> Histories;
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

    global TMap_Data__c () 
    {
    }
}