public with sharing class ProgramPartnerTeamInsert implements TriggerHandlerInterface {
    private Map<Id, List<AccountContactRelation>> accountContactRelationMap { get; set; }
    private Map<Id, List<Id>> programPartnerTeamMap { get; set; }
    private List<ProgramPartnerTeam__c> programPartnerTeamList = new List<ProgramPartnerTeam__c>();
    private static final Map<String, String> rolesMap = new Map<String, String>{
        'CS Admin Contact' => 'Admin',
        'CS Rep Contact' => 'Rep',
        'CS Program Signer' => 'Signer',
        'CS Support' => 'Support'
    };

    public void initialize(DataContainerInterface objectDataContainer) {
    }

    public void TriggerHandlerBeforeInsert(List<SObject> newTriggerList) {
    }
    public void TriggerHandlerAfterInsert(Map<Id, SObject> newTriggerMap) {
        insertProgramPartnerTeam(newTriggerMap);
    }
    public void TriggerHandlerBeforeUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
        insertProgramPartnerTeam(newTriggerMap);
    }
    public void TriggerHandlerAfterUpdate(Map<Id, SObject> newTriggerMap, Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerBeforeDelete(Map<Id, SObject> oldTriggerMap) {
    }
    public void TriggerHandlerAfterDelete(Map<Id, SObject> oldTriggerMap) {
    }

    private void insertProgramPartnerTeam(Map<Id, SObject> newTriggerMap) {
        Set<Id> idSet = newTriggerMap.keySet();

        this.getAccountContactRelation(newTriggerMap);

        this.programPartnerTeamMap = new QueriesbyProgramObjects.QueriesProgramPartnerTeam()
            .getProgramPartnerTeamByProgram(idSet);

        for (SObject program : newTriggerMap.values()) {
            if (program.get(ProgramConstants.PARTNERIDFIELD) != null) {
                if (this.accountContactRelationMap.get((Id) program.get(ProgramConstants.PARTNERIDFIELD)) != null) {
                    for (
                        AccountContactRelation accountContactRelation : this.accountContactRelationMap.get(
                            (Id) program.get(ProgramConstants.PARTNERIDFIELD)
                        )
                    ) {
                        checkProgramPartnerTeam(program.Id, accountContactRelation);
                    }
                }

                if (this.programPartnerTeamList.size() > 0) {
                    insert this.programPartnerTeamList;
                }
            }
        }
    }

    private void checkProgramPartnerTeam(Id programId, AccountContactRelation accountContactRelation) {
        Boolean add = false;
        if (this.programPartnerTeamMap.get(programId) == null) {
            add = true;
        } else {
            if (!this.programPartnerTeamMap.get(programId).contains(accountContactRelation.ContactId)) {
                add = true;
            }
        }

        if (add) {
            this.programPartnerTeamList.add(
                new ProgramPartnerTeam__c(
                    ProgramId__c = programId,
                    ContactId__c = accountContactRelation.ContactId,
                    Role__c = rolesMap.get(accountContactRelation.Roles),
                    Name = accountContactRelation.Contact.Name
                )
            );
        }
    }

    private void getAccountContactRelation(Map<Id, SObject> newTriggerMap) {
        Set<Id> idSet = new Set<Id>();

        for (SObject program : newTriggerMap.values()) {
            if (program.get(ProgramConstants.PARTNERIDFIELD) != null) {
                idSet.add((Id) program.get(ProgramConstants.PARTNERIDFIELD));
            }
        }

        if (idSet.size() > 0) {
            this.accountContactRelationMap = new QueriesbyObject.QueriesAccountContactRelation()
                .getAccountContactRelationInId(idSet);
        }
    }
}
