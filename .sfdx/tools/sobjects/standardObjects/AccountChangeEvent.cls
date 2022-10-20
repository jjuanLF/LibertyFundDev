// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class AccountChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global String LastName;
    global String FirstName;
    global String Salutation;
    global String MiddleName;
    global String Type;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Account Parent;
    global Id ParentId;
    global String BillingStreet;
    global String BillingCity;
    global String BillingState;
    global String BillingPostalCode;
    global String BillingCountry;
    global Double BillingLatitude;
    global Double BillingLongitude;
    global String BillingGeocodeAccuracy;
    global Address BillingAddress;
    global String ShippingStreet;
    global String ShippingCity;
    global String ShippingState;
    global String ShippingPostalCode;
    global String ShippingCountry;
    global Double ShippingLatitude;
    global Double ShippingLongitude;
    global String ShippingGeocodeAccuracy;
    global Address ShippingAddress;
    global String Phone;
    global String Fax;
    global String AccountNumber;
    global String Website;
    global String Sic;
    global String Industry;
    global Decimal AnnualRevenue;
    global Integer NumberOfEmployees;
    global String Ownership;
    global String TickerSymbol;
    global String Description;
    global String Rating;
    global String Site;
    global User Owner;
    global Id OwnerId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global String Jigsaw;
    global String JigsawCompanyId;
    global String AccountSource;
    global String SicDesc;
    global String Billing_Contact_Email__c;
    global String Billing_Contact__c;
    global Boolean Billing_Same_as_Shipping__c;
    global String Hotel_URL__c;
    /* AcctCode from Liberty Fund Conference database
    */
    global String LF_Account_Code__c;
    /* ID from Liberty Fund Conference database
    */
    global String LF_Vendor_ID__c;
    global String LF_Vendor_Number__c;
    global String Org_Desc__c;
    global String Org_Type__c;
    global String Vendor_Contact_Cell__c;
    global String Vendor_Contact_Email__c;
    global String Vendor_Contact__c;
    global String Billing_Contact_Phone__c;
    global String Billing_Contact_FAX__c;
    global String Shipping_Address_Display__c;
    global String Affiliation_Name__c;
    global String LID__LinkedIn_Company_Id__c;

    global AccountChangeEvent () 
    {
    }
}