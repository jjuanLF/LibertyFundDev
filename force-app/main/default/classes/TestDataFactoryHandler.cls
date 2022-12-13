public without sharing class TestDataFactoryHandler {
    private static Map<String, List<SObject>> sObjectMap = new Map<String, List<SObject>>();

    public class SObjectToCreate {
        public String objectName { get; set; }
        public Map<Integer, List<FieldValue>> recordsToCreateMap { get; set; }
    }

    public class FieldValue {
        public String field { get; set; }
        public Object value { get; set; }
        public Boolean isForeignKey { get; set; }
    }

    private static Map<String, List<SObject>> createTestData(List<SObjectToCreate> sObjectToCreateList) {
        List<SObject> recordsToInsertList = new List<SObject>();
        for (SObjectToCreate sObjectToCreate : sObjectToCreateList) {
            Schema.SObjectType objectType = Schema.getGlobalDescribe().get(sObjectToCreate.objectName);
            Map<String, Schema.SObjectField> fieldsMap = objectType.getDescribe().fields.getMap();

            for (Integer index : sObjectToCreate.recordsToCreateMap.keySet()) {
                SObject newObject = objectType.newSObject();
                for (FieldValue fieldValue : sObjectToCreate.recordsToCreateMap.get(index)) {
                    if (fieldValue.isForeignKey != null && fieldValue.isForeignKey) {
                        String parentName = fieldsMap.get(fieldValue.field)
                            .getDescribe()
                            .getReferenceTo()
                            .toString()
                            .replace('(', '')
                            .replace(')', '');

                        parentName = parentName.contains(',') ? 'User' : parentName;

                        newObject.put(
                            fieldValue.field,
                            sObjectMap.get(parentName)[Integer.valueOf(fieldValue.value)].Id
                        );
                    } else {
                        String type = String.valueOf(fieldsMap.get(fieldValue.field).getDescribe().getType());
                        switch on type {
                            when 'DATE' {
                                newObject.put(fieldValue.field, System.today());
                            }
                            when 'BOOLEAN' {
                                newObject.put(fieldValue.field, Boolean.valueOf(fieldValue.value));
                            }
                            when 'DOUBLE' {
                                newObject.put(fieldValue.field, Double.valueOf(fieldValue.value));
                            }
                            when 'CURRENCY' {
                                newObject.put(fieldValue.field, Integer.valueOf(fieldValue.value));
                            }
                            when else {
                                newObject.put(fieldValue.field, fieldValue.value);
                            }
                        }
                    }
                }
                insert newObject;
                sortSObjectRecords(newObject);
            }
        }
        return sObjectMap;
    }

    public static Profile getProfileByName(String profileName) {
        return [SELECT Id FROM Profile WHERE Name = :profileName];
    }

    static public RecordType getRecordType(String objectName, String developerName) {
        return [
            SELECT Id, DeveloperName
            FROM RecordType
            WHERE SobjectType = :objectName AND DeveloperName = :developerName
        ];
    }

    public static List<String> duplicateData(Integer numberToCreate, String data) {
        List<String> stringList = new List<String>();

        for (Integer i = 1; i <= numberToCreate; i++) {
            stringList.add(data.replaceAll('~', String.valueOf(i)));
        }
        return stringList;
    }

    public static Map<String, List<SObject>> createRecords(Map<String, List<String>> objectDataMap) {
        List<TestDataFactoryHandler.SObjectToCreate> sObjectToCreateList = new List<TestDataFactoryHandler.SObjectToCreate>();

        for (String objectName : objectDataMap.keySet()) {
            List<String> dataList = objectDataMap.get(objectName);
            Map<Integer, List<FieldValue>> recordsToCreateMap = new Map<Integer, List<FieldValue>>();

            for (Integer i = 0; i < dataList.size(); i++) {
                String[] fieldsValuesArray = dataList[i].split(',');
                List<TestDataFactoryHandler.FieldValue> fieldValueList = new List<TestDataFactoryHandler.FieldValue>();

                for (Integer ii = 0; ii < fieldsValuesArray.size(); ii++) {
                    TestDataFactoryHandler.FieldValue fieldValue = new TestDataFactoryHandler.FieldValue();
                    String[] fieldValueArray = fieldsValuesArray[ii].split('=');
                    Integer index = 1;

                    fieldValue.field = fieldValueArray[0].trim();
                    if (fieldValueArray.size() > 2) {
                        fieldValue.isForeignKey = true;
                        index = 2;
                    }
                    fieldValue.value = fieldValueArray[index];
                    fieldValueList.add(fieldValue);
                }
                recordsToCreateMap.put(i, fieldValueList);
            }
            TestDataFactoryHandler.SObjectToCreate sObjectToCreate = new TestDataFactoryHandler.SObjectToCreate();
            sObjectToCreate.objectName = objectName;
            sObjectToCreate.recordsToCreateMap = recordsToCreateMap;
            sObjectToCreateList.add(sObjectToCreate);
        }

        return createTestData(sObjectToCreateList);
    }

    private static void sortSObjectRecords(SObject sObjectRecord) {
        String sObjectName = String.valueOf(sObjectRecord.getSObjectType());
        if (sObjectMap.get(sObjectName) != null) {
            sObjectMap.get(sObjectName).add(sObjectRecord);
        } else {
            sObjectMap.put(sObjectName, new List<SObject>{ sObjectRecord });
        }
    }
}
