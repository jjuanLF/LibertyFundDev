// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sansancard__ScanToSalesforce_Setting__c {
    global Id Id;
    global Boolean IsDeleted;
    global String Name;
    global SObject SetupOwner;
    global Id SetupOwnerId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global String sansancard__AccountRecordType__c;
    global String sansancard__AccountValue__c;
    global String sansancard__ContactRecordType__c;
    global String sansancard__ContactValue__c;
    global Boolean sansancard__DisableAllCards__c;
    global Boolean sansancard__DisableDisplayReport__c;
    global Boolean sansancard__DisplayAllDeleteCards__c;
    global String sansancard__DisplayReportId__c;
    global String sansancard__DisplayReportName__c;
    global Boolean sansancard__EnableNotification__c;
    global Boolean sansancard__Enable_Contact__c;
    global Boolean sansancard__Enable_EditFields__c;
    global String sansancard__LeadRecordType__c;
    global String sansancard__LeadValue__c;
    global String sansancard__TransferDest__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
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

    global sansancard__ScanToSalesforce_Setting__c () 
    {
    }
}