// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__dsRecipient__c {
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
    global String Loop__Address__c;
    /* This can be made dynamic by using tags from the Field Tagger.
    */
    global String Loop__CustomAccessCode__c;
    /* This option will display the recipient(s)'s (contact, user, lead) title when initiating DocGen Packages.
    */
    global Boolean Loop__DisplayTitle__c;
    global String Loop__EmailText__c;
    global String Loop__Embedded_Signer__c;
    global String Loop__Host_Address__c;
    global Contact Loop__Host_Contact__r;
    global Id Loop__Host_Contact__c;
    global String Loop__Host_Role_Group_Names__c;
    global String Loop__Host_Static_Email__c;
    global String Loop__Host_Static_Name__c;
    global User Loop__Host_User__r;
    global Id Loop__Host_User__c;
    global Loop__DDP_Integration_Option__c Loop__IntegrationOption__r;
    global Id Loop__IntegrationOption__c;
    global String Loop__Language__c;
    global String Loop__OnAccessCodeFailed__c;
    global String Loop__OnCancel__c;
    global String Loop__OnDecline__c;
    global String Loop__OnException__c;
    global String Loop__OnIdCheckFailed__c;
    global String Loop__OnSessionTimeout__c;
    global String Loop__OnSigningComplete__c;
    global String Loop__OnTTLExpired__c;
    global String Loop__OnViewingComplete__c;
    /* Type the Role or User Group names separated by double commas for this recipient.
    */
    global String Loop__RoleGroupNames__c;
    global String Loop__SigningGroupId__c;
    global String Loop__SigningGroupName__c;
    /* When using the standard signing options, this number is used in the document to denote which options belong to this recipient. For example, if Recipient # is 2, the dl.signhere option will be typed into the document as "dl.signhere.2".
    */
    global Double Loop__SigningOrder__c;
    /* For an In Person Signer recipient, this is the person that will "host" the in person signing event (who the email is sent to).
    */
    global String Loop__Specified_Host__c;
    global String Loop__StaticEmail__c;
    global String Loop__StaticName__c;
    global String Loop__Subject__c;
    global Boolean Loop__dsAllowAccessCode__c;
    global Boolean Loop__dsCheckId__c;
    global Contact Loop__dsContact__r;
    global Id Loop__dsContact__c;
    global Boolean Loop__dsRequired__c;
    global String Loop__dsRoleName__c;
    /* This specifies the order in which recipients receive the document to sign.
    */
    global Double Loop__dsRoutingOrder__c;
    global String Loop__dsSignOptions__c;
    /* This changes which recipients the user can select from.
    */
    global String Loop__dsStaticRecipient__c;
    global String Loop__dsType__c;
    global User Loop__dsUser__r;
    global Id Loop__dsUser__c;
    global String Loop__Calc_Signing_Order__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Loop__SecureField__c> Loop__Secure_Fields__r;
    global List<Loop__dsRecipient__Share> Shares;
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

    global Loop__dsRecipient__c () 
    {
    }
}