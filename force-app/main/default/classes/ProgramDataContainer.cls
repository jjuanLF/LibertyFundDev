public without sharing class ProgramDataContainer implements DataContainerInterface {
    public Map<Id, List<Id>> narrativeListMap { get; set; }
    public List<GroupMember> groupMemberList { get; set; }
    public Map<Id, List<Checklist__c>> checklistMap { get; set; }
    public List<ProgramDocumentGeneration__c> programDocumentGeneration { get; set; }
    private static Map<String, Boolean> hasLoadedMap = new Map<String, Boolean>{
        'Checklist' => false,
        'Narratives' => false,
        'GroupMember' => false,
        'DocumentGeneration' => false
    };

    public void intialize() {
        if (!hasLoaded('Checklist') || this.checklistMap == null) {
            this.checklistMap = new QueriesbyObject.QueriesChecklist().getActiveChecklist();
        }
        if (!hasLoaded('Narrative') || this.narrativeListMap == null) {
            this.narrativeListMap = new QueriesbyObject.QueriesNarrativeType().getActiveNarrative();
        }
        if (!hasLoaded('GroupMember') || this.groupMemberList == null) {
            this.groupMemberList = new QueriesbyObject.QueriesGroupMember().getGroupMember();
        }
        if (!hasLoaded('DocumentGeneration') || this.programDocumentGeneration == null) {
            this.programDocumentGeneration = new QueriesbyObject.QueriesProgramDocumentGeneration()
                .getActiveProgramDocumentGeneration();
        }
    }
    public void reload() {
    }

    private static Boolean hasLoaded(String objectName) {
        if (hasLoadedMap.get(objectName) != null) {
            Boolean loaded = hasLoadedMap.get(objectName);
            if (!loaded) {
                hasLoadedMap.put(objectName, true);
            }
            return loaded;
        }

        return false;
    }
}
