// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ContactChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global Account Account;
    global Id AccountId;
    global String LastName;
    global String FirstName;
    global String Salutation;
    global String MiddleName;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
    global String OtherStreet;
    global String OtherCity;
    global String OtherState;
    global String OtherPostalCode;
    global String OtherCountry;
    global Double OtherLatitude;
    global Double OtherLongitude;
    global String OtherGeocodeAccuracy;
    global Address OtherAddress;
    global String MailingStreet;
    global String MailingCity;
    global String MailingState;
    global String MailingPostalCode;
    global String MailingCountry;
    global Double MailingLatitude;
    global Double MailingLongitude;
    global String MailingGeocodeAccuracy;
    global Address MailingAddress;
    global String Phone;
    global String Fax;
    global String MobilePhone;
    global String HomePhone;
    global String OtherPhone;
    global String AssistantPhone;
    global Contact ReportsTo;
    global Id ReportsToId;
    global String Email;
    global String Title;
    global String Department;
    global String AssistantName;
    global String LeadSource;
    global Date Birthdate;
    global String Description;
    global User Owner;
    global Id OwnerId;
    global Boolean HasOptedOutOfEmail;
    global Boolean HasOptedOutOfFax;
    global Boolean DoNotCall;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime LastCURequestDate;
    global Datetime LastCUUpdateDate;
    global String EmailBouncedReason;
    global Datetime EmailBouncedDate;
    global String Jigsaw;
    global String JigsawContactId;
    global Individual Individual;
    global Id IndividualId;
    global Boolean Active_Fellow__c;
    global Account Affiliation__c;
    global String Citizenship__c;
    global Double Conferences_Attended_Past_Year__c;
    global String Fellow_Code__c;
    global Date First_Conference_Date__c;
    global Campaign First_Conference__c;
    global Date First_DL_Date__c;
    global Date First_Director_Date__c;
    global Double Future_Conferences__c;
    global String LFPID__c;
    global String Primary_Expertise__c;
    global String Person_Type__c;
    global Double Total_Conferences_Attended__c;
    global String W9_Status__c;
    global String Gender__c;
    global String Region__c;
    global Double Count_as_Director__c;
    global Double Count_as_Disc_Lead__c;
    global Boolean Publication_Editor_Author__c;
    global Double Total_Attended_CoSpon_Only__c;
    global Double Total_Attended_Conferences_Only__c;
    global Boolean Website_Contributor__c;
    global String CRM_Person_Type__c;
    global String Evaluation_Image__c;
    global Double Evaluation_Count_Above_Exp__c;
    global Double Evaluation_Count_Below_Exp__c;
    global Double Evaluation_Count_Disruptive__c;
    global Double Evaluation_Count_Exceptional__c;
    global Double Evaluation_Count_Promising__c;
    global Double Evaluation_Count_Within_Exp__c;
    global String Website__c;
    global String Correspondence_Email__c;
    global String Public_Email__c;
    global String LF_Source__c;
    global Double Email_Count__c;
    global Boolean Vendor__c;
    global Date Most_Recent_Attended_Date__c;
    global String Name_Sort_Key__c;
    global Boolean TMap_Indicator__c;
    global String TMap_Image__c;
    /* check with accounting with questions
    */
    global String Intacct_Vendor_ID__c;
    global String Middle__c;
    global String CSPid__c;
    /* Provide the name the contact prefers to be called. Will be used for event name tags and table tents.
    */
    global String Display_Name__c;
    global String Contact_Record_Type__c;
    global String First_Middle_Names__c;
    global String RecordType_Name__c;
    global Double Corres_Email_Mngd_by_Int__c;
    global Double Public_Email_Mngd_by_Int__c;
    global String LID__LinkedIn_Company_Id__c;
    global String LID__LinkedIn_Member_Token__c;
    /* Field automatically updated by LinkedIn Sales Navigator Data Validation. “Not at Company” means Contact is not with associated Account based on LinkedIn profile. No value indicates LinkedIn has no feedback to share.
    */
    global String LID__No_longer_at_Company__c;
    global String Address_Notes__c;
    global String Asst_Email_Address__c;
    /* Click the Image icon to upload a photo.
    */
    global String Bio__c;
    global String Current_Correspondence_Address__c;
    global String Correspondence_Address__c;
    global Date Temp_Addr_End_Date__c;
    /* Please provide Street, City, State, Zip/Postal Code, and Country
    */
    global String Temporary_Address__c;
    global Boolean sansancard__CreatedByScanToSalesforce__c;
    global String Suffix__c;
    global String Public_Address__c;
    global Boolean Strategic_Person__c;
    global String Additional_Website1__c;
    global String Additional_Website2__c;
    global Date Strategic_Person_date__c;
    global String Strategic_Level__c;
    global String Strategic_Code__c;
    global Boolean Deceased__c;
    global String WorkPhone__c;
    global String PreferredPhone__c;
    global Boolean DoNotContact__c;
    global Account HouseholdId__c;
    global Account PrimaryAffiliationId__c;
    global String FullName__c;

    global ContactChangeEvent () 
    {
    }
}