public without sharing class ContactStagingConversion {
    public class ForeignKeyWrapper {
        private String table { get; set; }
        private String searchField { get; set; }
        private Set<Object> lookupSet { get; set; }
        private Map<Object, Id> queryResultMap { get; set; }
    }
    private static final String CONTACTSTAGINGTABLEOBJECT = 'ContactStagingTable__c';
    private static String soqlQuery = 'SELECT Id, $ FROM * WHERE $ IN (\'%\') WITH SECURITY_ENFORCED';
    private static Map<String, Integration_Staging_Table_Field_Mapping__mdt> fieldMappingMap = new Map<String, Integration_Staging_Table_Field_Mapping__mdt>();
    private static Map<String, ForeignKeyWrapper> foreignKeyWrapperMap = new Map<String, ForeignKeyWrapper>();

    public static Map<String, List<String>> convertContact() {
        List<Contact> contactList = new List<Contact>();
        List<ContactStagingTable__c> contactStagingTableList = ContactStagingQuery.getContactStagingTable();

        fieldMappingMap = IntegrationStagingTableFieldMappingQuery.IntegrationStagingTableFieldMappingByObject(
            CONTACTSTAGINGTABLEOBJECT
        );

        for (ContactStagingTable__c contactStagingTable : contactStagingTableList) {
            Map<String, Object> fieldValueMap = new Map<String, Object>();
            if (contactStagingTable.MergeContactId__c != null) {
                List<String> mergeFieldList = contactStagingTable.MergeFields__c.split(';');
                mergeFieldList.add('MergeContactId__c');

                for (String mergeField : mergeFieldList) {
                    fieldValueMap.put(mergeField, contactStagingTable.get(mergeField));
                }
            } else {
                fieldValueMap = contactStagingTable.getPopulatedFieldsAsMap();
            }
            contactList.add(createContactRecord(fieldValueMap));
        }
        queryResult();
        updateForeignKeys(contactList);
        return returnResults(Database.upsert(contactList, false), contactStagingTableList);
    }

    private static Contact createContactRecord(Map<String, Object> fieldValueMap) {
        Contact contact = new Contact();

        for (String field : fieldValueMap.keySet()) {
            if (fieldMappingMap.get(field) != null) {
                contact.put(fieldMappingMap.get(field).Target_Field__c, fieldValueMap.get(field));
                if (fieldMappingMap.get(field).Query_Object__c != null) {
                    if (foreignKeyWrapperMap.get(field) != null) {
                        foreignKeyWrapperMap.get(field).lookupSet.add(fieldValueMap.get(field));
                    } else {
                        ForeignKeyWrapper foreignKeyWrapper = new ForeignKeyWrapper();
                        foreignKeyWrapper.table = fieldMappingMap.get(field).Query_Object__c;
                        foreignKeyWrapper.searchField = fieldMappingMap.get(field).Query_Field__c;
                        foreignKeyWrapper.lookupSet = new Set<Object>{ fieldValueMap.get(field) };
                        foreignKeyWrapper.queryResultMap = new Map<Object, Id>();
                        foreignKeyWrapperMap.put(fieldMappingMap.get(field).Target_Field__c, foreignKeyWrapper);
                    }
                }
            }
        }
        return contact;
    }

    private static Map<String, List<String>> returnResults(
        List<Database.UpsertResult> upsertResultList,
        List<ContactStagingTable__c> contactStagingTableList
    ) {
        Map<String, List<String>> resultMap = new Map<String, List<String>>{
            'Created' => new List<String>(),
            'Updated' => new List<String>(),
            'Failed' => new List<String>()
        };
        List<ContactStagingTable__c> deleteRecordList = new List<ContactStagingTable__c>();
        List<ContactStagingTable__c> updateRecordList = new List<ContactStagingTable__c>();
        List<ProgramAttendee__c> insertProgramAttendeeList = new List<ProgramAttendee__c>();

        Integer i = 0;
        for (Database.UpsertResult upsertResult : upsertResultList) {
            String type = 'Updated';
            if (upsertResult.isSuccess()) {
                if (upsertResult.isCreated()) {
                    type = 'Created';
                }
                insertProgramAttendeeList.add(
                    new ProgramAttendee__c(
                        ProgramId__c = contactStagingTableList[i].ProgramId__c,
                        ContactId__c = upsertResult.id
                    )
                );
                deleteRecordList.add(new ContactStagingTable__c(id = contactStagingTableList[i].Id));
            } else {
                type = 'Failed';
                List<String> errorMessage = new List<String>();
                for (Database.Error error : upsertResult.getErrors()) {
                    errorMessage.add(error.getMessage());
                }
                updateRecordList.add(
                    new ContactStagingTable__c(
                        Id = contactStagingTableList[i].Id,
                        ErrorMessage__c = String.join(errorMessage, '\r\n')
                    )
                );
            }
            resultMap.get(type)
                .add(contactStagingTableList[i].First_Name__c + ' ' + contactStagingTableList[i].Last_Name__c);
            i++;
        }
        delete deleteRecordList;
        update updateRecordList;
		insert insertProgramAttendeeList;

        return resultMap;
    }

    private static void queryResult() {
        for (String field : foreignKeyWrapperMap.keySet()) {
            List<SObject> createSObjectList = new List<SObject>();
            List<SObject> recordList = Database.query(
                soqlQuery.replace('*', foreignKeyWrapperMap.get(field).table)
                    .replace('$', foreignKeyWrapperMap.get(field).searchField)
                    .replace('%', String.join(new List<Object>(foreignKeyWrapperMap.get(field).lookupSet), ','))
            );

            for (SObject record : recordList) {
                foreignKeyWrapperMap.get(field)
                    .queryResultMap.put(record.get(foreignKeyWrapperMap.get(field).searchField), (Id) record.get('Id'));
            }

            for (Object objectValue : foreignKeyWrapperMap.get(field).lookupSet) {
                if (foreignKeyWrapperMap.get(field).queryResultMap.get(objectValue) == null) {
                    SObject newRecord = Schema.getGlobalDescribe()
                        .get(foreignKeyWrapperMap.get(field).table)
                        .newSObject();
                    newRecord.put(foreignKeyWrapperMap.get(field).searchField, objectValue);
                    createSObjectList.add(newRecord);
                }
            }

            insert createSObjectList;
            for (SObject record : createSObjectList) {
                foreignKeyWrapperMap.get(field)
                    .queryResultMap.put(record.get(foreignKeyWrapperMap.get(field).searchField), (Id) record.get('Id'));
            }
        }
    }

    private static void updateForeignKeys(List<Contact> contactList) {
        for (Contact contact : contactList) {
            Map<String, Object> populatedFieldsMap = contact.getPopulatedFieldsAsMap();
            for (String field : populatedFieldsMap.keySet()) {
                if (foreignKeyWrapperMap.get(field) != null) {
                    for (Object value : foreignKeyWrapperMap.get(field).queryResultMap.keySet()) {
                        contact.put(field, foreignKeyWrapperMap.get(field).queryResultMap.get(value));
                    }
                }
            }
        }
    }
}
