public without sharing class ProgramNarrativeInsert implements TriggerHandlerInterface {
    private ProgramDataContainer programDataContainer { get; set; }
    private Map<Id, List<Id>> programNarrativeMap { get; set; }
    private List<ProgramNarrative__c> programNarrativeList = new List<ProgramNarrative__c>();

    public void initialize(DataContainerInterface objectDataContainer) {
        this.programDataContainer = (ProgramDataContainer) objectDataContainer;
    }

    public void TriggerHandlerBeforeInsert(List<SObject> newTriggerList) {
    }
    public void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap) {
        insertProgramNarrative(newTriggerMap);
    }
    public void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        insertProgramNarrative(newTriggerMap);
    }
    public void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap) {
    }

    private void insertProgramNarrative(Map<Id, SObject> newTriggerMap) {
        Set<Id> idSet = newTriggerMap.keySet();
        this.programNarrativeMap = new QueriesbyProgramObjects.QueriesProgramNarrative()
            .getProgramNarrativeByProgram(idSet);

        for (SObject program : newTriggerMap.values()) {
            if (program.get(ProgramConstants.REPEATPROGRAMFIELD) == null)
                if (
                    this.programDataContainer.narrativeListMap.get(
                        (Id) program.get(ProgramConstants.RECORDTYPEIDFIELD)
                    ) != null
                ) {
                    for (
                        Id id : this.programDataContainer.narrativeListMap.get(
                            (Id) program.get(ProgramConstants.RECORDTYPEIDFIELD)
                        )
                    ) {
                        checkProgramNarrative(program.Id, Id);
                    }
                }
        }
        if (this.programNarrativeList.size() > 0) {
            insert this.programNarrativeList;
        }
    }

    private void checkProgramNarrative(Id programId, Id narrativeTypeId) {
        Boolean add = false;
        if (this.programNarrativeMap.get(programId) == null) {
            add = true;
        } else {
            if (!this.programNarrativeMap.get(programId).contains(narrativeTypeId)) {
                add = true;
            }
        }

        if (add) {
            this.programNarrativeList.add(
                new ProgramNarrative__c(ProgramId__c = programId, NarrativeTypeId__c = narrativeTypeId)
            );
        }
    }
}
