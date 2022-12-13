public with sharing class ProgramRepeatProgam implements TriggerHandlerInterface {
    private ProgramDataContainer programDataContainer { get; set; }
    private Map<Id, ProgramSession__c> newProgramSessionMap = new Map<Id, ProgramSession__c>();
    private Map<Id, List<ProgramSessionReading__c>> newProgramSessionReadingMap = new Map<Id, List<ProgramSessionReading__c>>();

    public void initialize(DataContainerInterface objectDataContainer) {
        this.programDataContainer = (ProgramDataContainer) objectDataContainer;
    }
    public void TriggerHandlerBeforeInsert(List<SObject> newTriggerList) {
    }
    public void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap) {
        this.copyProgram(newTriggerMap);
    }
    public void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        Map<Id, SObject> repeatTriggerMap = new Map<Id, SObject>();
        for (Id id : newTriggerMap.keySet()) {
            if (
                newTriggerMap.get(id).get(ProgramConstants.REPEATPROGRAMFIELD) !=
                oldTriggerMap.get(id).get(ProgramConstants.REPEATPROGRAMFIELD)
            ) {
                repeatTriggerMap.put(id, newTriggerMap.get(id));
            }
        }

        if (repeatTriggerMap.size() > 0) {
            this.copyProgram(repeatTriggerMap);
        }
    }
    public void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap) {
    }

    private void copyProgram(Map<Id, SObject> newTriggerMap) {
        Map<Id, Id> idMap = new Map<Id, Id>();
        Set<Id> deleteIdSet = new Set<Id>();
        for (SObject program : newTriggerMap.values()) {
            if (program.get(ProgramConstants.REPEATPROGRAMFIELD) != null) {
                idMap.put((Id) program.get(ProgramConstants.REPEATPROGRAMFIELD), program.Id);
                deleteIdSet.add(program.Id);
            }
        }

        if (idMap.size() > 0) {
            Map<Id, List<ProgramSession__c>> programSessionMap = new QueriesbyProgramObjects.QueriesProgramSession()
                .getProgramSessionsSessionReadingsByProgram(idMap.keySet());
            Map<Id, List<ProgramNarrative__c>> programNarrativeMap = new QueriesbyProgramObjects.QueriesProgramNarrative()
                .getProgramNarrativeByProgram(idMap.keySet(), false, false);
            List<ProgramNarrative__c> newProgramNarrativeList = new List<ProgramNarrative__c>();

            for (Id id : idMap.keySet()) {
                if (programSessionMap.get(id) != null) {
                    for (ProgramSession__c programSession : programSessionMap.get(id)) {
                        ProgramSession__c newProgramSession = programSession.clone();
                        List<ProgramSessionReading__c> newProgramSessionReadingList = programSession.ProgramSessionReading__r.deepClone();

                        newProgramSession.ProgramId__c = idMap.get(id);
                        this.newProgramSessionMap.put(programSession.Id, newProgramSession);

                        this.newProgramSessionReadingMap.put(programSession.Id, newProgramSessionReadingList);
                    }
                }
                if (programNarrativeMap.get(id) != null) {
                    for (ProgramNarrative__c programNarrative : programNarrativeMap.get(id)) {
                        ProgramNarrative__c newProgramNarrative = programNarrative.clone();
                        newProgramNarrative.ProgramId__c = idMap.get(id);
                        newProgramNarrativeList.add(newProgramNarrative);
                    }
                }

                if (this.newProgramSessionMap.size() > 0) {
                    insert this.newProgramSessionMap.values();
                    this.updateProgramSessionId();
                }
            }

            if (newProgramNarrativeList.size() > 0) {
                List<ProgramNarrative__c> deleteProgramNarrativeList = new List<ProgramNarrative__c>();
                delete new QueriesbyProgramObjects.QueriesProgramNarrative()
                    .getProgramNarrativeByProgram(deleteIdSet, false);

                insert newProgramNarrativeList;
            }
        }
    }

    private void updateProgramSessionId() {
        List<ProgramSessionReading__c> insertProgramSessionReadingList = new List<ProgramSessionReading__c>();
        for (Id id : this.newProgramSessionMap.keySet()) {
            for (ProgramSessionReading__c programSessionReading : this.newProgramSessionReadingMap.get(id)) {
                programSessionReading.ProgramSessionId__c = this.newProgramSessionMap.get(id).Id;
                insertProgramSessionReadingList.add(programSessionReading);
            }
        }
        insert insertProgramSessionReadingList;
    }
}
