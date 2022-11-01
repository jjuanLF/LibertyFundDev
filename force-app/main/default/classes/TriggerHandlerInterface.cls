public interface TriggerHandlerInterface {
	void TriggerHandlerBeforeInsert(List<SObject> newTriggerList);
	void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap);
	void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap);
	void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap);
	void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap);
	void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap);
}
