public without sharing class CalculateFullNameForDuplicateCheck implements TriggerHandlerInterface {
    private static final String CONTACTOBJECT = 'Contact';
    private static final String FULLNAMEFIELD = 'FullName__c';
    private static final String NAMESORTKEYFIELD = 'Name_Sort_Key__c';
    private static final String CONTACTSTAGINGTABLEOBJECT = 'ContactStagingTable__c';
    private static final Map<String, List<String>> OBJECTNAMEFIELDMAP = new Map<String, List<String>>{
        CONTACTOBJECT => new List<String>{ 'FirstName', 'MiddleName', 'LastName' },
        CONTACTSTAGINGTABLEOBJECT => new List<String>{ 'First_Name__c', 'Middle__c', 'Last_Name__c' }
    };

    private static final Map<String, String> characterMap = new Map<String, String>{
        'ÀÁÂÃÄÅ' => 'A',
        'Ç' => 'C',
        'Ð' => 'D',
        'ÈÉÊË' => 'E',
        'ÌÍÎÏ' => 'I',
        'Ñ' => 'N',
        'ÒÓÔÕÖ' => 'O',
        'ÙÚÛÜ' => 'U',
        'ÝŸ' => 'Y'
    };

    public void initialize(DataContainerInterface objectDataContainer) {
    }

    public void TriggerHandlerBeforeInsert(List<SObject> newTriggerList) {
        calculateFullName(newTriggerList);
    }
    public void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap) {
    }
    public void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        List<SObject> newTriggerList = new List<SObject>();

        for (Id id : newTriggerMap.keySet()) {
            if (
                newTriggerMap.get(id).get(NAMESORTKEYFIELD) != oldTriggerMap.get(id).get(NAMESORTKEYFIELD)
            ) {
                newTriggerList.add(newTriggerMap.get(id));
            }
        }
        calculateFullName(newTriggerList);
    }
    public void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap) {
    }

    private void calculateFullName(List<SObject> newTriggerList) {
        for (SObject sObjectRecord : newTriggerList) {
            String fullName = '';

            for (String fieldName : OBJECTNAMEFIELDMAP.get(sObjectRecord.getSObjectType().getDescribe().name)) {
                if (sObjectRecord.get(fieldName) != null) {
                    fullName += (String) sObjectRecord.get(fieldName);
                }
            }

            fullName = fullName.toUpperCase().replaceAll('(\\s+|@|&|\'|\\(|\\)|<|>|#|\\.|-|%)', '').trim();

            for (Integer i = 0; i < fullName.length(); i++) {
                String searchCharacter = fullName.mid(i, 1);

                for (String foreignCharacter : characterMap.keySet()) {
                    if (foreignCharacter.contains(searchCharacter)) {
                        fullName = fullName.replaceAll(searchCharacter, characterMap.get(foreignCharacter));
                    }
                }
            }

            String[] fullNameList = fullName.split('');
            fullNameList.sort();

            sObjectRecord.put(FULLNAMEFIELD, String.join(fullNameList, ''));
        }
    }
}
