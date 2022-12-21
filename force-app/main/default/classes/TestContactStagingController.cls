@IsTest
private class TestContactStagingController {
    private static Map<String, List<SObject>> sObjectMap { get; set; }

    @IsTest
    static void testImportContact() {
        makeData();
        Id tempContactId = sObjectMap.get(TestDataFactoryConstants.CONTACTSTAGINGTABLEOBJECT)[0].Id;
        Id contactId = sObjectMap.get(TestDataFactoryConstants.CONTACTOBJECT)[0].Id;
        System.assert(ContactStagingController.getPossibleDuplicates(tempContactId).size() > 0);
        System.assert(
            ContactStagingController.setContactToMerge(
                tempContactId,
                contactId,
                new List<String>{
                    TestDataFactoryConstants.FIRSTNAMEFIELD,
                    TestDataFactoryConstants.LASTNAMEFIELD,
                    TestDataFactoryConstants.EMAILFIELD
                }
            )
        );

        System.assert(ContactStagingController.convertContact().size() > 0);
    }

    static void makeData() {
        Id profileId = TestDataFactoryHandler.getProfileByName(TestDataFactoryConstants.PROFILELFADMIN).Id;
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
                'ConferenceType__c=Colloquium,FiscalYear__c=2023-24,LFRepId__c=Index=0,OwnerId=Index=0,' +
                'Name=Testing,ProgramTitle__c=Testing,ProposalId__c=1234-556,ProposedCityCountry__c=Anywhere USA,ProposedDate__c=Summer 2022,' +
                'ProposedTimeline__c=1 Week,RecordTypeId=' +
                TestDataFactoryHandler.getRecordType(TestDataFactoryConstants.PROGRAMOBJECT, 'Co_Sponsor').Id +
                ',' +
                'Region__c=North America,Stage__c=Proposal,SubStage__c=Exploratory - Initiated'
            },
            TestDataFactoryConstants.CONTACTSTAGINGTABLEOBJECT => new List<String>{
                'First_Name__c=Liberty,Last_Name__c=Fund,Affiliation_Name__c=LF,ProgramId__c=Index=0,Correspondence_Email__c=test@libertyfund.org',
                'First_Name__c=Liber,Last_Name__c=Fun,Affiliation_Name__c=LF,ProgramId__c=Index=0,Correspondence_Email__c=test@libertysfund.org',
                'Affiliation_Name__c=LF,ProgramId__c=Index=0,Correspondence_Email__c=stest@liberstyfund.org'
            }
        };

        sObjectMap = TestDataFactoryHandler.createRecords(setupDataMap);
    }
}
