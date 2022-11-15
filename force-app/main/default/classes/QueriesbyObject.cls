public without sharing class QueriesbyObject {
    private static final String PROGRAMOBJECT = 'Program__c';

    public class QueriesNarrativeType {
        public Map<Id, List<Id>> getActiveNarrative() {
            Map<Id, List<Id>> narrativeTypeMap = new Map<Id, List<Id>>();
            List<NarrativeType__c> narrativeTypeList = [
                SELECT Id, Type__c
                FROM NarrativeType__c
                WHERE Active__c = TRUE
            ];

            List<RecordType> recordTypeList = new QueriesbyObject.QueriesRecordType()
                .getRecordTypeByObject(PROGRAMOBJECT);

            for (NarrativeType__c narrativeType : narrativeTypeList) {
                for (RecordType recordType : recordTypeList) {
                    if (recordType.Name == narrativeType.Type__c) {
                        if (narrativeTypeMap.get(recordType.Id) == null) {
                            narrativeTypeMap.put(recordType.Id, new List<Id>{ narrativeType.Id });
                        } else {
                            narrativeTypeMap.get(recordType.Id).add(narrativeType.Id);
                        }
                    }
                }
            }

            return narrativeTypeMap;
        }
    }

    public class QueriesRecordType {
        public List<RecordType> getRecordTypeByObject(String sObjectType) {
            return [SELECT Id, Name FROM RecordType WHERE SobjectType = :sObjectType];
        }
    }

    public class QueriesGroupMember {
        public List<GroupMember> getGroupMember() {
            return [SELECT UserOrGroupId, Group.DeveloperName FROM GroupMember];
        }
    }
}
