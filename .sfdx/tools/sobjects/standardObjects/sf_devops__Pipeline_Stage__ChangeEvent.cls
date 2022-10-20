// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class sf_devops__Pipeline_Stage__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global sf_devops__Pipeline__c sf_devops__Pipeline__c;
    global String sf_devops__Branch_Name__c;
    global String sf_devops__Branch_Remote_Reference__c;
    /* The branch in the VCS that this stage is associated with.
    */
    global sf_devops__Branch__c sf_devops__Branch__c;
    global sf_devops__Environment__c sf_devops__Environment__c;
    global sf_devops__Pipeline_Stage__c sf_devops__Next_Stage__c;
    global sf_devops__Async_Operation_Result__c sf_devops__Operation_Status__c;
    global String sf_devops__Promote_Review_Remote_Reference__c;
    global Boolean sf_devops__Versioned__c;
    global Boolean sf_devops__Prerelease__c;

    global sf_devops__Pipeline_Stage__ChangeEvent () 
    {
    }
}