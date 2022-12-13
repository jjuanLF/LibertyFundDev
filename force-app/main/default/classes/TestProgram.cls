@Istest
private class TestProgram {
    private static Map<String, List<SObject>> sObjectMap { get; set; }

    @Istest
    static void testProgram() {
        makeData();
        for (SObject program : sObjectMap.get(TestDataFactoryConstants.PROGRAMOBJECT)) {
            program.put(TestDataFactoryConstants.BUDGETAMOUNTFIELD, 200);
        }

        update sObjectMap.get(TestDataFactoryConstants.PROGRAMOBJECT);
    }
    @Istest
    static void testRepeatProgram() {
        makeData();

        TestDataFactoryHandler.createRecords(
            new Map<String, List<String>>{
                TestDataFactoryConstants.PROGRAMOBJECT => new List<String>{
                    'BudgetAmount__c=100,PartnerId__c=Index=0,PartnerRepId__c=Index=0,ConfereeType__c=Academic,' +
                    'ConferenceType__c=Colloquium,DocumentVersion__c=Draft,FiscalYear__c=2023-24,LFRepId__c=Index=0,OwnerId=Index=0,' +
                    'Name=Repeat,ProgramTitle__c=Repeat,ProposalId__c=4231-123,ProposedCityCountry__c=Anywhere USA,ProposedDate__c=Summer 2022,' +
                    'ProposedTimeline__c=1 Week,RecordTypeId=' +
                    TestDataFactoryHandler.getRecordType(TestDataFactoryConstants.PROGRAMOBJECT, 'Co_Sponsor').Id +
                    ',RepeatProgramId__c=' +
                    sObjectMap.get(TestDataFactoryConstants.PROGRAMOBJECT)[0].Id +
                    ',Region__c=North America,Stage__c=Proposal,SubStage__c=Exploratory - Initiated'
                }
            }
        );
    }

    static void makeData() {
        Id profileId = TestDataFactoryHandler.getProfileByName(PROFILELFADMIN).Id;
        Map<String, List<String>> setupDataMap = new Map<String, List<String>>{
            'User' => TestDataFactoryHandler.duplicateData(
                2,
                ('FirstName=Test,LastName=User~,Alias=Test~,Email=testuser~@test.ca.devs,' +
                'Username=testuser~@test.ca.devs.dev,CommunityNickname=testuser~,' +
                'TimeZoneSidKey=America/New_York,LocaleSidKey=en_CA,EmailEncodingKey=ISO-8859-1,' +
                'LanguageLocaleKey=en_US,ProfileId=' +
                profileId)
            ),
            TestDataFactoryConstants.ACCOUNTOBJECT => new List<String>{ 'Name=LF' },
            TestDataFactoryConstants.CONTACTOBJECT => new List<String>{
                'FirstName=Liberty,LastName=Fund,AccountId=Index=0,Email=test@libertyfund.org'
            },
            TestDataFactoryConstants.CHECKLISTOBJECT => new List<String>{
                'Active__c=TRUE,Body__c=Test,DaysTaskDue__c=1,EmailReminderDays__c=1,Name=Test,' +
                'SubStage__c=Exploratory - Initiated,Type__c=Co-Sponsor',
                'Active__c=TRUE,Body__c=Test1,DaysTaskDue__c=1,EmailReminderDays__c=1,Name=Test1,' +
                'SubStage__c=Exploratory - Initiated,Type__c=Co-Sponsor',
                'Active__c=TRUE,Body__c=Test1,DaysTaskDue__c=1,EmailReminderDays__c=1,Name=Test1,' +
                'SubStage__c=Exploratory - Rep,Type__c=Co-Sponsor'
            },
            TestDataFactoryConstants.CITATIONOBJECT => new List<String>{ 'Name=Test' },
            TestDataFactoryConstants.LOOPDDPOBJECT => new List<String>{ 'Name=Test' },
            TestDataFactoryConstants.NARRATIVETYPEOBJECT => new List<String>{
                'Active__c=TRUE,Name=Test,SortOrder__c=1,Type__c=Co-Sponsor',
                'Active__c=TRUE,Name=Test2,SortOrder__c=2,Type__c=Co-Sponsor'
            },
            TestDataFactoryConstants.PROGRAMDOCUMENTGENERATIONOBJECT => new List<String>{
                'Active__c=TRUE,DocGenPackageId__c=Index=0,Name=Test'
            },
            TestDataFactoryConstants.PROGRAMDOCUMENTGENERATIONSUBSTAGEOBJECT => new List<String>{
                'CurrentSubStage__c=Exploratory - Initiated,PreviousSubStage__c=Exploratory - Initiated,ProgramDocumentGenerationId__c=Index=0,Version__c=Draft',
                'CurrentSubStage__c=Exploratory - Initiated,PreviousSubStage__c=Exploratory - Initiated,ProgramDocumentGenerationId__c=Index=0,Version__C=Final'
            },
            TestDataFactoryConstants.PROGRAMOBJECT => new List<String>{
                'BudgetAmount__c=100,PartnerId__c=Index=0,PartnerRepId__c=Index=0,ConfereeType__c=Academic,' +
                'ConferenceType__c=Colloquium,DocumentVersion__c=Draft,FiscalYear__c=2023-24,LFRepId__c=Index=0,OwnerId=Index=0,' +
                'Name=Testing,ProgramTitle__c=Testing,ProposalId__c=1234-556,ProposedCityCountry__c=Anywhere USA,ProposedDate__c=Summer 2022,' +
                'ProposedTimeline__c=1 Week,RecordTypeId=' +
                TestDataFactoryHandler.getRecordType(TestDataFactoryConstants.PROGRAMOBJECT, 'Co_Sponsor').Id +
                ',' +
                'Region__c=North America,Stage__c=Proposal,SubStage__c=Exploratory - Initiated'
            },
            TestDataFactoryConstants.PROGRAMCHECKLISTOBJECT => new List<String>{
                'ChecklistId__c=Index=0,Completed__c=false,LastEmailType__c=Initial,ProgramId__c=Index=0,Name=Test',
                'ChecklistId__c=Index=1,Completed__c=false,LastEmailType__c=Initial,ProgramId__c=Index=0,Name=Test'
            },
            TestDataFactoryConstants.PROGRAMSESSIONOBJECT => new List<String>{
                'Name=Test,Narrative__c=Test,ProgramId__c=Index=0,Sequence__c=1,Session__c=Session I,Title__c=Test',
                'Name=Test2,Narrative__c=Test2,ProgramId__c=Index=0,Sequence__c=2,Session__c=Session II,Title__c=Test2'
            },
            TestDataFactoryConstants.PROGRAMSESSIONREADINGOBJECT => new List<String>{
                'Chapter__c=Test,CitationId__c=Index=0,ReadingListType__c=Book,ProgramSessionId__c=Index=0,SortOrder__c=1',
                'Chapter__c=Test1,CitationId__c=Index=0,ReadingListType__c=Book,ProgramSessionId__c=Index=0,SortOrder__c=2',
                'Chapter__c=Test,CitationId__c=Index=0,ReadingListType__c=Book,ProgramSessionId__c=Index=1,SortOrder__c=1',
                'Chapter__c=Test1,CitationId__c=Index=0,ReadingListType__c=Book,ProgramSessionId__c=Index=1,SortOrder__c=2'
            }
        };

        sObjectMap = TestDataFactoryHandler.createRecords(setupDataMap);
    }
}
