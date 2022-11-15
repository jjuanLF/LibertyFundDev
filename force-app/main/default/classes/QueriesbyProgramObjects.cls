public without sharing class QueriesbyProgramObjects {
    public class QueriesProgramTeam {
        public Map<Id, List<Id>> getProgramTeamByProgram(Set<Id> idSet) {
            Map<Id, List<Id>> programTeamMap = new Map<Id, List<Id>>();

            List<ProgramTeam__c> programTeamList = [
                SELECT UserId__c, ProgramId__c
                FROM ProgramTeam__c
                WHERE ProgramId__c IN :idSet
            ];

            for (ProgramTeam__c programTeam : programTeamList) {
                if (programTeamMap.get(programTeam.ProgramId__c) != null) {
                    programTeamMap.get(programTeam.ProgramId__c).add(programTeam.UserId__c);
                } else {
                    programTeamMap.put(programTeam.ProgramId__c, new List<Id>{ programTeam.UserId__c });
                }
            }

            return programTeamMap;
        }
    }

    public class QueriesProgramNarrative {
        public Map<Id, List<Id>> getProgramNarrativeByProgram(Set<Id> idSet) {
            Map<Id, List<Id>> programNarrativeMap = new Map<Id, List<Id>>();

            List<ProgramNarrative__c> programNarrativeList = this.privateGetProgramNarrativeByProgram(idSet);

            for (ProgramNarrative__c programNarrative : programNarrativeList) {
                if (programNarrativeMap.get(programNarrative.ProgramId__c) != null) {
                    programNarrativeMap.get(programNarrative.ProgramId__c).add(programNarrative.NarrativeTypeId__c);
                } else {
                    programNarrativeMap.put(
                        programNarrative.ProgramId__c,
                        new List<Id>{ programNarrative.NarrativeTypeId__c }
                    );
                }
            }

            return programNarrativeMap;
        }

        public List<ProgramNarrative__c> getProgramNarrativeByProgram(Set<Id> idSet, Boolean optionalParam) {
            return this.privateGetProgramNarrativeByProgram(idSet);
        }

        public Map<Id, List<ProgramNarrative__c>> getProgramNarrativeByProgram(
            Set<Id> idSet,
            Boolean optionalParam,
            Boolean optionalParam1
        ) {
            Map<Id, List<ProgramNarrative__c>> programNarrativeMap = new Map<Id, List<ProgramNarrative__c>>();

            List<ProgramNarrative__c> programNarrativeList = this.privateGetProgramNarrativeByProgram(idSet);

            for (ProgramNarrative__c programNarrative : programNarrativeList) {
                if (programNarrativeMap.get(programNarrative.ProgramId__c) != null) {
                    programNarrativeMap.get(programNarrative.ProgramId__c).add(programNarrative);
                } else {
                    programNarrativeMap.put(
                        programNarrative.ProgramId__c,
                        new List<ProgramNarrative__c>{ programNarrative }
                    );
                }
            }

            return programNarrativeMap;
        }

        private List<ProgramNarrative__c> privateGetProgramNarrativeByProgram(Set<Id> idSet) {
            return [
                SELECT NarrativeTypeId__c, ProgramId__c, Narrative__c
                FROM ProgramNarrative__c
                WHERE ProgramId__c IN :idSet
            ];
        }
    }

    public class QueriesProgramSession {
        public Map<Id, List<ProgramSession__c>> getProgramSessionsSessionReadingsByProgram(Set<Id> idSet) {
            Map<Id, List<ProgramSession__c>> programSessionMap = new Map<Id, List<ProgramSession__c>>();

            List<ProgramSession__c> programSessionList = [
                SELECT
                    Session__c,
                    Title__c,
                    Narrative__c,
                    Sequence__c,
                    ProgramId__c,
                    (
                        SELECT Id, Chapter__c, CitationId__c, ProgramSessionId__c, PublicationTitle__c, SortOrder__c, Pages__c
                        FROM ProgramSessionReading__r
                    )
                FROM ProgramSession__c
                WHERE ProgramId__c IN :idSet
            ];

            for (ProgramSession__c programSession : programSessionList) {
                if (programSessionMap.get(programSession.ProgramId__c) != null) {
                    programSessionMap.get(programSession.ProgramId__c).add(programSession);
                } else {
                    programSessionMap.put(programSession.ProgramId__c, new List<ProgramSession__c>{ programSession });
                }
            }

            return programSessionMap;
        }
    }
}