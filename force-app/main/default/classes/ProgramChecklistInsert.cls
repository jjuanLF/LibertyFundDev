public without sharing class ProgramChecklistInsert implements TriggerHandlerInterface {
    private ProgramDataContainer programDataContainer { get; set; }
    private Map<Id, List<ProgramChecklist__c>> programChecklistMap { get; set; }
    private List<ProgramChecklist__c> programChecklistList = new List<ProgramChecklist__c>();

    public void initialize(DataContainerInterface objectDataContainer) {
        this.programDataContainer = (ProgramDataContainer) objectDataContainer;
    }

    public void TriggerHandlerBeforeInsert(List<SObject> newTriggerList) {
    }
    public void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap) {
        insertProgramChecklist(newTriggerMap);
    }
    public void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        insertProgramChecklist(newTriggerMap);
    }
    public void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap) {
    }

    private void insertProgramChecklist(Map<Id, SObject> newTriggerMap) {
        Set<Id> idSet = newTriggerMap.keySet();

        this.programChecklistMap = new QueriesbyProgramObjects.QueriesProgramChecklist()
            .getProgramChecklistByProgram(idSet);

        for (SObject program : newTriggerMap.values()) {
            this.checkProgramChecklist((Program__C) program);
        }

        if (this.programChecklistList.size() > 0) {
            insert this.programChecklistList;
        }
    }

    private void checkProgramChecklist(Program__c program) {
        if (this.programDataContainer.checklistMap != null && this.programDataContainer.checklistMap.get(program.RecordTypeId) != null) {
            for (Checklist__c checklist : this.programDataContainer.checklistMap.get(program.RecordTypeId)) {
                if (program.SubStage__c != checklist.SubStage__c) {
                    continue;
                }

                Boolean add = true;
                if (this.programChecklistMap.get(program.Id) != null) {
                    for (ProgramChecklist__c programChecklist : this.programChecklistMap.get(program.Id)) {
                        if (programChecklist.ChecklistId__c == checklist.Id) {
                            add = false;
                            break;
                        }
                    }
                }

                if (add) {
                    this.programChecklistList.add(
                        new ProgramChecklist__c(
                            ProgramId__c = program.Id,
                            ChecklistId__c = checklist.Id,
                            Name = checklist.Name,
                            LastEmailDate__c = Date.today()
                        )
                    );
                }
            }
        }
    }
}
