public with sharing class ContactStagingQuery {
    public static ContactStagingTable__c getContactStagingTableById(Id id) {
        return [
            SELECT First_Name__c, Last_Name__c, FullName__c, Email__c, Affiliation_Name__c, Public_Email__c
            FROM ContactStagingTable__c
            WHERE Id = :id
        ];
    }

    public static List<ContactStagingTable__c> getContactStagingTable() {
        return [
            SELECT
                Address1__c,
                AddressType__c,
                Affiliation_Name__c,
                Affiliation_Title__c,
                Assistant_Email__c,
                Assistant_Name__c,
                Assistant_Phone__c,
                City__c,
                Country__c,
                Email__c,
                First_Name__c,
                FullName__c,
                Last_Name__c,
                MergeContactId__c,
                MergeFields__c,
                Middle__c,
                Mobile__c,
                Person_Type__c,
                Phone__c,
                PostalCode__c,
                Primary_Expertise__c,
                ProgramId__c,
                Salutation__c,
                ShortBio__c,
                State__c,
                URL__c
            FROM ContactStagingTable__c
        ];
    }
}
