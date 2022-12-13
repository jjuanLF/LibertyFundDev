public with sharing class DisplayController {
    @AuraEnabled(cacheable=true)
    public static List<ProgramSession__c> getProgramSession(Id id) {
        try {
            return new QueriesbyProgramObjects.QueriesProgramSession().getProgramSessionsSessionReadingsByProgram(id);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getPageLayout(List<String> pageLayoutList) {
        return JSON.serialize(PageLayoutRetriever.getPageLayout(pageLayoutList));
    }

    @AuraEnabled(cacheable=true)
    public static List<ProgramNarrative__c> getProgramNarrative(Id id) {
        try {
            return new QueriesbyProgramObjects.QueriesProgramNarrative()
                .getProgramNarrativeByProgram(new Set<Id>{ Id }, false);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static User getUserInfo() {
        try {
            return new QueriesbyObject.QueriesUser().getUserInfo();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static boolean finishSession(Id id) {
        Map<String, Object> flowMap = new Map<String, Object>();
        try {
            flowMap.put('recordId', new Program__c(Id=id));
            Flow.Interview.FinishProgramSession flow = new Flow.Interview.FinishProgramSession(flowMap);
            flow.start();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return true;
    }
}
