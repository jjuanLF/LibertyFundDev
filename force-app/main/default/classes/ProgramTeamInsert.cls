public without sharing class ProgramTeamInsert implements TriggerHandlerInterface {
    private ProgramDataContainer programDataContainer { get; set; }
    private Map<Id, List<Id>> programTeamMap { get; set; }
    private List<ProgramTeam__c> programTeamList = new List<ProgramTeam__c>();

    public void initialize(DataContainerInterface objectDataContainer) {
        this.programDataContainer = (ProgramDataContainer) objectDataContainer;
    }
    public void TriggerHandlerBeforeInsert(List<SObject> newTriggerList) {
    }
    public void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap) {
        insertProgramTeam(newTriggerMap);
    }
    public void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        insertProgramTeam(newTriggerMap);
    }
    public void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap) {
    }

    private void insertProgramTeam(Map<Id, SObject> newTriggerMap) {
        Set<Id> idSet = newTriggerMap.keySet();
        this.programTeamMap = new QueriesbyProgramObjects.QueriesProgramTeam().getProgramTeamByProgram(idSet);

        for (SObject program : newTriggerMap.values()) {
            if (this.programDataContainer.groupMemberList.size() > 0) {
                for (GroupMember groupMember : this.programDataContainer.groupMemberList) {
                    if (groupMember.Group.DeveloperName == ProgramConstants.COSPONSORGROUP) {
                        checkProgramTeam(program.Id, groupMember.UserOrGroupId);
                    }
                }
            }
        }
        if (programTeamList.size() > 0) {
            insert programTeamList;
        }
    }

    private void checkProgramTeam(Id programId, Id userId) {
        Boolean add = false;
        if (this.programTeamMap.get(programId) == null) {
            add = true;
        } else {
            if (!this.programTeamMap.get(programId).contains(userId)) {
                add = true;
            }
        }

        if (add) {
            this.programTeamList.add(new ProgramTeam__c(ProgramId__c = programId, UserId__c = userId));
        }
    }
}
