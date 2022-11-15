public without sharing class ProgramDataContainer implements DataContainerInterface {
    public Map<Id, List<Id>> narrativeListMap { get; set; }
    public List<GroupMember> groupMemberList { get; set; }
    private static Map<String, Boolean> hasLoadedMap = new Map<String, Boolean>{
        'Narratives' => false,
        'GroupMember' => false
    };

    public void intialize() {
        if (!hasLoaded('Narrative')) {
            this.narrativeListMap = new QueriesbyObject.QueriesNarrativeType().getActiveNarrative();
        }
        if (!hasLoaded('GroupMember')) {
            this.groupMemberList = new QueriesbyObject.QueriesGroupMember().getGroupMember();
        }
    }
    public void reload() {
    }

    private Boolean hasLoaded(String objectName) {
        if (hasLoadedMap.get(objectName) && hasLoadedMap.get(objectName) != null) {
            return true;
        }
        hasLoadedMap.get(objectName) = true;
        return false;
    }
}
