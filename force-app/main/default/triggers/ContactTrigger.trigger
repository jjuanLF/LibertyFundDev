trigger ContactTrigger on Contact(
    before insert,
    before update,
    after insert,
    after update,
    before delete,
    after delete
) {
    private static final String TRIGGEROBJECT = 'Contact';
    TriggerHandler triggerHandler = new TriggerHandler(TRIGGEROBJECT, false);

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            triggerHandler.TriggerHandlerBeforeInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            triggerHandler.TriggerHandlerBeforeUpdate(Trigger.newMap, Trigger.oldMap);
        }
        if (Trigger.isDelete) {
            triggerHandler.TriggerHandlerBeforeDelete(Trigger.oldMap);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            triggerHandler.TriggerHandlerAfterInsert(Trigger.newMap);
        }
        if (Trigger.isUpdate) {
            triggerHandler.TriggerHandlerAfterUpdate(Trigger.newMap, Trigger.oldMap);
        }
        if (Trigger.isDelete) {
            triggerHandler.TriggerHandlerAfterDelete(Trigger.oldMap);
        }
    }
}
