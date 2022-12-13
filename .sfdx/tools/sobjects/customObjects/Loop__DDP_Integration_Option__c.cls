// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Loop__DDP_Integration_Option__c {
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
    global Loop__DDP__c Loop__DDP__r;
    global Id Loop__DDP__c;
    /* If left blank, the file name of the PDF will be used.
    */
    global String Loop__Agreement_Name__c;
    /* Allows the user to choose to store the DocGen Package based on the Attach As field.
    */
    global Boolean Loop__AllowOutputAttachment__c;
    global String Loop__AttachDocsTo__c;
    /* Attachment will create a Salesforce attachment; LOOP Storage will create a document in the LOOP Storage interface; Content and Content - User Selected will create a Content document in the appropriate Workspace.
    */
    global String Loop__Attach_As__c;
    /* None or Default will use the default Authoritative Copy setting specified in your DocuSign account configuration.
    */
    global String Loop__Authoritative_Copy__c;
    global String Loop__Brand_Id__c;
    global String Loop__CC__c;
    /* This will default the 'Additional To' field when delivering the DocGen Package via email. Use the Field Tagger to use dynamic email addresses.
    */
    global String Loop__CI_Additional_To__c;
    /* This will default the 'BCC' field when delivering the DocGen Package via email. Use the Field Tagger to use dynamic email addresses.
    */
    global String Loop__CI_BCC__c;
    /* This will default the 'CC' field when delivering the DocGen Package via email. Use the Field Tagger to use dynamic email addresses.
    */
    global String Loop__CI_CC__c;
    global String Loop__DDP_File_Template__c;
    global String Loop__Data_Mapping_Id__c;
    global String Loop__Data_Mapping_Name__c;
    /* Decryption is currently only supported with CipherCloud. Contact Nintex to enable this for your organization.
    */
    global Boolean Loop__Decryption_Required__c;
    global String Loop__Delivery_Data__c;
    /* Text entered here will be displayed when users hover over this option's info icon.
    */
    global String Loop__Description_Hover__c;
    /* This option prevents all recipients from using the Print, Sign, and Fax option during the signing process.
    */
    global Boolean Loop__Disable_Wet_Sign__c;
    /* You can use Box share links in your email templates. Use the appropriate tags from the Field Tagger.
    */
    global Boolean Loop__Email_Doc_Links__c;
    global Boolean Loop__Enable_In_Person_Signing__c;
    global Boolean Loop__Enable_Revisions__c;
    global String Loop__Encrypted_Token__c;
    global Boolean Loop__EnforceSignerVisibility__c;
    /* The FTP domain where you wish to store the document including any subfolders (e.g. ftp.yoursite.com/folder1/folder2/). The folders can be made dynamic using the Field Tagger.
    */
    global String Loop__FTPDomain__c;
    /* The user name for your FTP domain.
    */
    global String Loop__FTPUserName__c;
    /* Select this option if your Email Text includes HTML markup.
    */
    global Boolean Loop__HTML_Email__c;
    global Boolean Loop__Hosted_Signing__c;
    /* Checking this option will remove the contact or lead reference on the email page.
    */
    global Boolean Loop__Internal_Email__c;
    global String Loop__Language__c;
    global String Loop__Limit_Availability__c;
    global String Loop__Location__c;
    global String Loop__Message__c;
    global Double Loop__Order__c;
    global String Loop__OrgWideEmailAddress__c;
    global String Loop__OrgWideEmailId__c;
    global String Loop__OrgWideEmailName__c;
    global String Loop__Output__c;
    /* Use the Field Tagger to make this value dynamic.
    */
    global String Loop__Password__c;
    global Boolean Loop__PasswordonPDF__c;
    global Boolean Loop__PasswordtoSign__c;
    /* Format the parameters as if on a query string (paramName=smplVal&p2=sV2). This can be made dynamic using tags from the Field Tagger.
    */
    global String Loop__PostParameters__c;
    /* Text entered here will be displayed if there is a preview step.
    */
    global String Loop__Preview_Step_Help_Text__c;
    global String Loop__Queue_Folder_Id__c;
    /* A URL used to redirect 3rd party processes.
    */
    global String Loop__Redirect_URL__c;
    global String Loop__Remind_Recipient__c;
    /* The DocGen Package file will be stored based on the selected storage location. The default is to store the document as an attachment on the originating record.
    */
    global Boolean Loop__RequireOutputAttachment__c;
    global String Loop__SMTPDomain__c;
    global String Loop__SMTPUserName__c;
    global String Loop__SMTP_Password__c;
    global String Loop__SMTP_Username__c;
    /* If selected, the transfer will be done over SSL.
    */
    global Boolean Loop__SSL__c;
    global Boolean Loop__SenderSigns__c;
    global String Loop__Signature_Order__c;
    global String Loop__Signature_Type__c;
    /* Automatically send the DocGen Package to its destination (no PDF preview).
    */
    global Boolean Loop__SkipPreview__c;
    global String Loop__Storage_Data__c;
    /* Type the folder structure for where you want to store the output. You can use the Field Tagger to dynamically determine your folders. Example: folder/sub folder/last folder
    */
    global String Loop__Storage_Folder__c;
    /* This option allows the user to add or move signatures and other signing options on the file before sending out to the recipients.
    */
    global Boolean Loop__Tag_Before_Sending__c;
    global String Loop__Template__c;
    /* If returning an original Word document, this option will turn on tracking within the file.
    */
    global Boolean Loop__TurnTrackingOn__c;
    global String Loop__Type__c;
    /* If unchecked, the user does not see the processing screen while the DocGen Package is being generated.
    */
    global Boolean Loop__Wait__c;
    global String Loop__WorkspaceId__c;
    global String Loop__WorkspaceName__c;
    /* If checked, users will be able to change the subject and email text when running a DocGen Package.
    */
    global Boolean Loop__dsAllowEmailCustomizations__c;
    /* Comma-semicolon delimited string: each field separated by a semicolon, each parameter per field separated by a comma. E.g. "custmFld1Name, custmFld1Val; custmFld2Name, <<Account_Id>>". This value is dynamic, see the associated help topic.
    */
    global String Loop__dsCustomFields__c;
    /* Use the Field Tagger to make this dynamic.
    */
    global String Loop__dsEmailText__c;
    /* Expire signing in # days. 0 days will never expire.
    */
    global Double Loop__dsExpireAfter__c;
    /* Warn of expiration # days prior to expiration.
    */
    global Double Loop__dsExpireWarn__c;
    /* If selected, the user will be able to change the defaults for the expirations and reminders.
    */
    global Boolean Loop__dsExposeExpirations__c;
    /* Send Reminder in # days. 0 days will not send a reminder.
    */
    global Double Loop__dsReminderDelay__c;
    /* Repeat reminder every # days until complete.
    */
    global Double Loop__dsReminderFrequency__c;
    /* Use the Field Tagger to make this dynamic. Examples: "Quote <<Opportunity_Quote_Num>>" or "<<Account_Name>> Proposal".
    */
    global String Loop__dsSubject__c;
    /* The Template Id from the DocuSign Console. When using a Template Id, the roles of the recipients in the template must match the roles of the recipients in the related list below.
    */
    global String Loop__dsTemplateId__c;
    global String Loop__Content_Workspace__c;
    global String Loop__Data_Mapping__c;
    /* Use a DocGen Package File or Salesforce Email Template for email deliveries.
    */
    global String Loop__Email_Template__c;
    global String Loop__FTP__c;
    global String Loop__Org_Wide_Email__c;
    /* If no option is selected, the default is Enhanced.
    */
    global String Loop__PDF_Option__c;
    global String Loop__Storage_Location__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Loop__DDP__c> Loop__Document_Packages__r;
    global List<Loop__dsRecipient__c> Loop__Recipients__r;
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

    global Loop__DDP_Integration_Option__c () 
    {
    }
}