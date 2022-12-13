@Istest
private class TestCustomPathController {
    private static Map<String, List<SObject>> sObjectMap { get; set; }

    @Istest
    static void testGetDependentPicklistValues() {
        Map<Object, List<String>> sObjectPicklistMap = CustomPathController.getDependentPicklistValues(
            TestDataFactoryConstants.PROGRAMOBJECT,
            TestDataFactoryConstants.SUBSTAGEFIELD
        );
        System.assert(sObjectPicklistMap.size() > 0);
    }
    @Istest
    static void testUpdateSubStage() {
        makeData();

        System.assert(
            CustomPathController.updateSubStage(
                sObjectMap.get(TestDataFactoryConstants.PROGRAMOBJECT)[0].Id,
                'Exploratory - Rep'
            ) == 'Success'
        );
    }

    static void makeData() {
        Id profileId = TestDataFactoryHandler.getProfileByName(PROFILELFADMIN).Id;
        Map<String, List<String>> setupDataMap = new Map<String, List<String>>{
            TestDataFactoryConstants.USEROBJECT => TestDataFactoryHandler.duplicateData(
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
            TestDataFactoryConstants.PROGRAMOBJECT => new List<String>{
                'BudgetAmount__c=100,PartnerId__c=Index=0,PartnerRepId__c=Index=0,ConfereeType__c=Academic,' +
                'ConferenceType__c=Colloquium,DocumentVersion__c=Draft,FiscalYear__c=2023-24,LFRepId__c=Index=0,OwnerId=Index=0,' +
                'Name=Testing,ProgramTitle__c=Testing,ProposalId__c=1234-556,ProposedCityCountry__c=Anywhere USA,ProposedDate__c=Summer 2022,' +
                'ProposedTimeline__c=1 Week,RecordTypeId=' +
                TestDataFactoryHandler.getRecordType(PROGRAMOBJECT, 'Co_Sponsor').Id +
                ',' +
                'Region__c=North America,Stage__c=Proposal,SubStage__c=Exploratory - Initiated'
            }
        };

        sObjectMap = TestDataFactoryHandler.createRecords(setupDataMap);
    }
}
