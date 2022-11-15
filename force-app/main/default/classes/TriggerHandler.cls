public without sharing class TriggerHandler {
    private List<TriggerHandlerInterface> executeFunctionsList;

    public TriggerHandler(String table, Boolean hasDataContainer) {
        DataContainerInterface objectDataContainer = null;
        executeFunctionsList = new List<TriggerHandlerInterface>();
        List<TriggerHandlerFunction__mdt> triggerHandlerFunctionList = TriggerHandlerFunctionQuery.getTriggerHandlerFunctionsByObject(
            table
        );

        if (hasDataContainer) {
            objectDataContainer = (DataContainerInterface) Type.forName(table.replace('__c', '') + 'DataContainer')
                .newInstance();
        }

        for (TriggerHandlerFunction__mdt triggerHandlerFunction : triggerHandlerFunctionList) {
            TriggerHandlerInterface triggerHandler = (TriggerHandlerInterface) Type.forName(
                    triggerHandlerFunction.ApexClass__c
                )
                .newInstance();

            triggerHandler.initialize(objectDataContainer);
            this.executeFunctionsList.add(triggerHandler);
        }
    }

    public void TriggerHandlerBeforeInsert(List<SObject> newTriggerList) {
        for (TriggerHandlerInterface function : this.executeFunctionsList) {
            function.TriggerHandlerBeforeInsert(newTriggerList);
        }
    }
    public void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap) {
        for (TriggerHandlerInterface function : this.executeFunctionsList) {
            function.TriggerHandlerAfterInsert(newTriggerMap);
        }
    }
    public void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        for (TriggerHandlerInterface function : this.executeFunctionsList) {
            function.TriggerHandlerBeforeUpdate(newTriggerMap, oldTriggerMap);
        }
    }
    public void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        for (TriggerHandlerInterface function : this.executeFunctionsList) {
            function.TriggerHandlerAfterUpdate(newTriggerMap, oldTriggerMap);
        }
    }
    public void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap) {
        for (TriggerHandlerInterface function : this.executeFunctionsList) {
            function.TriggerHandlerBeforeDelete(oldTriggerMap);
        }
    }
    public void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap) {
        for (TriggerHandlerInterface function : this.executeFunctionsList) {
            function.TriggerHandlerAfterDelete(oldTriggerMap);
        }
    }
}
