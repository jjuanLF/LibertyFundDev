public without sharing class ProgramDocumentGenerate implements TriggerHandlerInterface {
    private ProgramDataContainer programDataContainer { get; set; }

    public void initialize(DataContainerInterface objectDataContainer) {
        this.programDataContainer = (ProgramDataContainer) objectDataContainer;
    }

    public void TriggerHandlerBeforeInsert(List<SObject> newTriggerList) {
    }
    public void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap) {
    }
    public void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        generateDocuments(newTriggerMap, oldTriggerMap);
    }
    public void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap) {
    }

    public void generateDocuments(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        for (SObject program : newTriggerMap.values()) {
            for (
                ProgramDocumentGeneration__c programDocumentGeneration : this.programDataContainer.programDocumentGeneration
            ) {
                for (
                    ProgramDocumentGenerationSubStage__c programDocumentGenerationSubStage : programDocumentGeneration.ProgramDocumentGenerationSubStages__r
                ) {
                    if (
                        program.get(ProgramConstants.SUBSTAGEFIELD) ==
                        programDocumentGenerationSubStage.CurrentSubStage__c &&
                        oldTriggerMap.get(program.Id).get(ProgramConstants.SUBSTAGEFIELD) ==
                        programDocumentGenerationSubStage.PreviousSubStage__c
                    ) {
                        Set<String> attachmentIdSet = new Set<String>();
                        String recordType = programDocumentGenerationSubStage.Version__c ==
                            ProgramConstants.DRAFTVERSION
                            ? 'Email'
                            : 'Email-Final';
                        runDocGenPackage(
                            program.Id,
                            programDocumentGeneration.DocGenPackageId__c,
                            attachmentIdSet,
                            recordType
                        );
                    }
                }
            }
        }
    }

    @Future(callout=true)
    private static void runDocGenPackage(Id id, Id docGenPackageId, Set<String> attachmentIdSet, String recordType) {
        if (!System.Test.isRunningTest()) {
            Loop__DDP_Integration_Option__c loopDDPIntegrationOption = new QueriesbyObject.QueriesLoopDDPIntegrationOption()
                .getLoopDDPIntegrationOption(docGenPackageId, recordType);

            Map<String, String> variablesMap = new Map<String, String>{
                'deploy' => loopDDPIntegrationOption.Id,
                'attachIds' => String.join(new List<String>(attachmentIdSet), '|')
            };

            Loop.loopMessage.send(id, docGenPackageId, variablesMap);
        }
    }
}
