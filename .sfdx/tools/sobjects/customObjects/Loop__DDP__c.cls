// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__DDP__c {
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
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String Loop__AdHoc_Apex_Class__c;
    /* Enter the field name that stores a Document Id to include the document(s) in the DocGen Package. (Use the Field Tagger with Document Type set to Excel.)
    */
    global String Loop__AddendumDocIdField__c;
    /* Allows the user to choose to store the DocGen Package output as determined by the Attach As field.
    */
    global Boolean Loop__AllowOutputAttachment__c;
    /* This allows the user to add attachments from the associated objects to the end of the DocGen Package.
    */
    global Boolean Loop__Allow_Attachments__c;
    global Boolean Loop__Allow_UserId_Override__c;
    /* Attachment will create a Salesforce attachment; LOOP Storage will create a document in the LOOP Storage interface; Content and Content - User Selected will create a Content document in the appropriate Workspace.
    */
    global String Loop__Attach_As__c;
    global String Loop__Business_User__c;
    /* This will default the 'Additional To' field when delivering the DocGen Package via email. Use the Field Tagger to use dynamic email addresses.
    */
    global String Loop__DDP_Additional_To__c;
    /* This will default the 'BCC' field when delivering the DocGen Package via email. Use the Field Tagger to use dynamic email addresses.
    */
    global String Loop__DDP_BCC__c;
    /* This will default the 'CC' field when delivering the DocGen Package via email.Use the Field Tagger to use dynamic email addresses.
    */
    global String Loop__DDP_CC__c;
    /* For internal use.
    */
    global String Loop__Description__c;
    global String Loop__Document_Type__c;
    global String Loop__Email_Template__c;
    global String Loop__Enclosure_Folder_Id__c;
    /* Limit the number of enclosures that can be selected.
    */
    global Double Loop__Enclosure_Limit__c;
    /* If selected, the user cannot send this DocGen Package to a Salesforce email template.
    */
    global Boolean Loop__Exclude_Email__c;
    /* If selected, the user cannot send this DocGen Package to LOOP. LOOP is a PDF conversion service. It can be used to upload ad hoc documents to convert to PDF and combine with other documents into one PDF.
    */
    global Boolean Loop__Exclude_LOOP__c;
    /* If selected, the user cannot send this DocGen Package to the DocGen Queue. The DocGen Queue allows DocGen Packages to be generated behind the scenes and allows for inter-department fulfillment options.
    */
    global Boolean Loop__Exclude_Queue__c;
    /* Use this value with the filter and filtertype querystring parameters on your custom button or link to filter which DocGen Packages are listed. Filtertype options are equals, doesnotequal, startswith, endswith, contains, and doesnotcontain.
    */
    global String Loop__Filter__c;
    /* Once activated, your report will be emailed out at this frequency.
    */
    global String Loop__Frequency__c;
    global String Loop__Industry__c;
    global Boolean Loop__IsActive__c;
    /* Files from selected article types can be included at DocGen Package run time.

Use Shift or Ctrl to select multiple options. Use Ctrl to deselect.
    */
    global String Loop__KA_Optional__c;
    /* All files from selected Article Types will be included with the DocGen Package automatically.

Use Shift or Ctrl to select multiple options. Use Ctrl to deselect.
    */
    global String Loop__KA_Required__c;
    /* Files from selected article types can be included as separate attachments at run time. (If an article has more than one file field, the files will be listed as separate options.)

Use Shift or Ctrl to select multiple options. Use Ctrl to deselect.
    */
    global String Loop__KA_Separate__c;
    global Boolean Loop__Keep_Word_Formulas__c;
    /* Once activated, this field will be updated each time the report is sent out.
    */
    global Datetime Loop__LastSent__c;
    /* If no options are selected, the DocGen Package will be available for all deployment types.
    */
    global String Loop__Limit_Availability__c;
    /* Use Limit Availability instead.
    */
    global String Loop__Limit_Deployment__c;
    /* This will override the user's locale when running a DocGen Package. The value must be a valid locale (e.g. en-us, en-uk, fr-ca, etc.). Use the Field Tagger to dynamically set the locale.
    */
    global String Loop__Locale__c;
    /* This is a Salesforce Report Id. The first column (# zero) of the report must be the lead, contact, or user id that the report will be emailed to. Each consecutive column can be used in a report filter as !param# where # is the column number.
    */
    global String Loop__MassEmailReport__c;
    global String Loop__Mass_Email_Report_Name__c;
    /* Enter the API name of the custom object this DocGen Package should be available from.
    */
    global String Loop__Object_Name__c;
    /* DocGen Package Templates will be processed using this version of Office. This does not need to match the version that the DocGen Package Templates were created/modified in.
    */
    global String Loop__Office_Version__c;
    global String Loop__OrgWideEmailAddress__c;
    global String Loop__OrgWideEmailId__c;
    global String Loop__OrgWideEmailName__c;
    /* This is the name for the DocGen Package output file. Use the Field Tagger to make this dynamic. Examples: "Quote <<Opportunity_Quote_Num>>" or "<<Account_Name>> Proposal".
    */
    global String Loop__Output_Filename__c;
    global String Loop__Output__c;
    global String Loop__Preview_URL__c;
    /* Semi-colon delimited list of at most 6 values. Defaults to: initializing docgen package; security check; acquiring data; looping documents; combining docgen package; routing docgen package. For no processing text, type null.
    */
    global String Loop__ProcessingText__c;
    global Boolean Loop__Published__c;
    /* Documents sent to the Queue from this DocGen Package will be stored in this Document Folder.
    */
    global String Loop__Queue_Folder_Id__c;
    global String Loop__Quote_Attachments__c;
    global String Loop__RelatedContent__c;
    /* This field has been deprecated. Use the Related Object list instead. (Values in this field will overwrite the Related Object list.)
    */
    global String Loop__RelatedObjects__c;
    /* If data in a Salesforce report contains bad/invalid characters, checking this option will remove them from the data.
    */
    global Boolean Loop__Remove_Invalid_Characters__c;
    /* The LOOP It delivery option will be renamed to this value.
    */
    global String Loop__RenameLOOP__c;
    /* If selected, the user must select an attachment to be appended to the DocGen Package. This option requires Allow Attachments to also be selected.
    */
    global Boolean Loop__RequireAttachment__c;
    /* If selected, the user must select a contact to be used with this DocGen Package.
    */
    global Boolean Loop__RequireContact__c;
    /* The DocGen Package output will be stored as specified in the Attach As field.
    */
    global Boolean Loop__RequireOutputAttachment__c;
    global Loop__DDP_Integration_Option__c Loop__Scheduled_Delivery_Option__r;
    global Id Loop__Scheduled_Delivery_Option__c;
    global String Loop__SecurityType__c;
    global Boolean Loop__Skip_AdHoc_Processing__c;
    global String Loop__Time__c;
    global String Loop__Type__c;
    global String Loop__WorkspaceId__c;
    global String Loop__WorkspaceName__c;
    global String Loop__Case_Articles__c;
    global String Loop__Content_Workspace__c;
    /* If monthly is selected and you specify a day between 29 and 31, the report runs only in the months that contain that day.
    */
    global String Loop__Day__c;
    global String Loop__Default_Email_Template__c;
    /* This is a Salesforce Report. The first column (# zero) of the report must be the lead, contact, or user id that the report will be emailed to. Each consecutive column can be used in a report filter as !param# where # is the column number.
    */
    global String Loop__Mass_Email_Report_to__c;
    global String Loop__Object_Name_Link__c;
    /* For information on Organization-Wide Addresses, search the Salesforce Help site for organization-wide addresses.
    */
    global String Loop__Org_Wide_Email__c;
    global String Loop__ReportStatus__c;
    global String Loop__Security__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Loop__DDP_File__c> Loop__DDP_Files__r;
    global List<Loop__DDP_Integration_Option__c> Loop__Custom_Integration_Options__r;
    global List<Loop__DDP_Text_Group__c> Loop__DDP_Text_Groups__r;
    global List<Loop__DDP__Share> Shares;
    global List<Loop__Form_Field__c> Loop__Form_Fields__r;
    global List<Loop__Form_Rule__c> Loop__Form_Rules__r;
    global List<Loop__Form_Step__c> Loop__Form_Steps__r;
    global List<Loop__Insert_Update__c> Loop__Insert_Updates__r;
    global List<Loop__PDF_Stamp__c> Loop__PDF_Stamps__r;
    global List<Loop__Related_Object__c> Loop__Related_Objects__r;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<ProgramDocumentGeneration__c> ProgramDocumentsGeneration__r;
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

    global Loop__DDP__c () 
    {
    }
}