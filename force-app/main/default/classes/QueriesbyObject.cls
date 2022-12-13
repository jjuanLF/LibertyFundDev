public without sharing class QueriesbyObject {
    private static final String PROGRAMOBJECT = 'Program__c';

    public class QueriesNarrativeType {
        public Map<Id, List<Id>> getActiveNarrative() {
            Map<Id, List<Id>> narrativeTypeMap = new Map<Id, List<Id>>();
            List<NarrativeType__c> narrativeTypeList = [
                SELECT Id, Type__c
                FROM NarrativeType__c
                WHERE Active__c = TRUE ORDER BY SortOrder__c
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

    public class QueriesUser {
        public User getUserInfo() {
            String userId = UserInfo.getUserId();
            return [
                SELECT ID, FirstName, LastName, Name, Title, Profile.Name, Email
                FROM User
                WHERE ID = :userId
                LIMIT 1
            ];
        }
    }

    public class QueriesChecklist {
        public Map<Id, List<Checklist__c>> getActiveChecklist() {
            Map<Id, List<Checklist__c>> checklistMap = new Map<Id, List<Checklist__c>>();
            List<Checklist__c> checklistList = [
                SELECT Id, Body__c, DaysTaskDue__c, EmailReminderDays__c, Name, SubStage__c, Type__c
                FROM Checklist__c
                WHERE Active__c = TRUE
            ];
            List<RecordType> recordTypeList = new QueriesbyObject.QueriesRecordType()
                .getRecordTypeByObject(PROGRAMOBJECT);

            for (Checklist__c checklist : checklistList) {
                for (RecordType recordType : recordTypeList) {
                    if (recordType.Name == checklist.Type__c) {
                        if (checklistMap.get(recordType.Id) == null) {
                            checklistMap.put(recordType.Id, new List<Checklist__c>{ checklist });
                        } else {
                            checklistMap.get(recordType.Id).add(checklist);
                        }
                    }
                }
            }

            return checklistMap;
        }
    }

    public class QueriesProgramDocumentGeneration {
        public List<ProgramDocumentGeneration__c> getActiveProgramDocumentGeneration() {
            return [
                SELECT
                    DocGenPackageId__c,
                    (SELECT PreviousSubStage__c, CurrentSubStage__c, Version__c FROM ProgramDocumentGenerationSubStages__r)
                FROM ProgramDocumentGeneration__c
                WHERE Active__c = TRUE
            ];
        }
    }

    public class QueriesLoopDDPIntegrationOption {
        public Loop__DDP_Integration_Option__c getLoopDDPIntegrationOption(Id loopDDPId, String recordType) {
            return [
                SELECT Id
                FROM Loop__DDP_Integration_Option__c
                WHERE Loop__DDP__c = :loopDDPId AND RecordType.Name = :recordType
                LIMIT 1
            ];
        }
    }
}
