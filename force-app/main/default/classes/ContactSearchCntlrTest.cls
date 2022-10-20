@isTest
Public class ContactSearchCntlrTest {
    
    static testMethod void ContactSearch(){
        
        Contact c= new contact();
        c.Firstname='Test';
        c.lastName='LastName1';
        c.MailingState = 'CA';
        c.MailingCountry = 'USA';
        c.Region__c = 'NA';        
        c.Most_Recent_Attended_Date__c = system.today();
        insert c;

        // special setup required in test classes for SOSL search
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = c.id;
        Test.setFixedSearchResults(fixedSearchResults);

        searchParamsRequest req = new searchParamsRequest();
        req.page=1;
        req.pageSize=25;
        req.isValueMissing=true;
        req.searchwithName=false;
        req.SearchLow='0';
        req.SearchHigh='1';
        req.searchMailingCountry='USA';
        req.searchMailingState='CA';
        req.searchRegion='NA';
        req.searchAttendance=true;
        req.searchSponsorCheck=true;
        req.searchContWebSiteCheck=true;
        req.searchPublicationCheck=true;
        req.searchDirectedConfCheck=true;
        req.searchLeadConfCheck=true;
        req.searchPersonType='Yes';
        req.searchPrimaryExpertise='Test';
        req.searchWithName=true;
        req.filterEvalExc=true;
        req.filterEvalAbove=true;
        req.filterEvalWithin=true;
        req.filterEvalProm=true;
        req.filterEvalBelow=true;
        req.filterEvalDisruptive=true;
        req.searchLeads=false;
        req.searchKeyword='Test';
        req.isRecentlyActive=true;
        req.numActiveYears='10';
        req.sortField='Name';
        req.isAsc=true;
        req.offsetCount = 0;
        req.queryLimit=20;

        string reqJSON = JSON.serialize(req);
        
        Test.startTest();
        ContactSearchCntlr.fetchContact(reqJSON);
        Test.StopTest();
    }

    
    static testMethod void LeadSearch(){
        
        Lead l= new Lead();
        l.Firstname='Test';
        l.lastName='LastName';
        l.Company='TestCo';
        l.State = 'CA';
        l.Country = 'USA';
        l.Region__c = 'NA';
        insert l;

        // special setup required in test classes for SOSL search
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = l.id;
        Test.setFixedSearchResults(fixedSearchResults);

        searchParamsRequest req = new searchParamsRequest();
        req.page=1;
        req.pageSize=25;
        req.isValueMissing=true;
        req.searchwithName=false;
        req.SearchLow='';
        req.SearchHigh='';
        req.searchMailingCountry='USA';
        req.searchMailingState='CA';
        req.searchRegion='NA';
        req.searchAttendance=false;
        req.searchSponsorCheck=false;
        req.searchContWebSiteCheck=false;
        req.searchpublicationCheck=false;
        req.searchDirectedConfCheck=false;
        req.searchLeadConfCheck=false;
        req.searchPersonType='';
        req.searchPrimaryExpertise='Test';
        req.searchWithName=false;
        req.filterEvalExc=false;
        req.filterEvalAbove=false;
        req.filterEvalWithin=false;
        req.filterEvalProm=false;
        req.filterEvalBelow=false;
        req.filterEvalDisruptive=false;
        req.searchLeads=True;
        req.searchKeyword='Test';
        req.sortField='Name';
        req.isRecentlyActive=true;
		req.numActiveYears='10';
        req.isAsc=true;
        req.offsetCount = 0;
        req.queryLimit=20;

        string reqJSON = JSON.serialize(req);
        
        Test.startTest();
        ContactSearchCntlr.fetchContact(reqJSON);
        Test.StopTest();
    }
    
    /**
* @description: Wrapper class used to deserialize search/create requests sent from client
**/
    private class searchParamsRequest {
        @TestVisible
        private Integer page;
        @TestVisible
        private Integer pageSize;
        @TestVisible
        private Boolean isValueMissing;
        @TestVisible
        private Boolean searchWithName;
        @TestVisible
        private String SearchLow;
        @TestVisible
        private String SearchHigh;
        @TestVisible
        private String searchMailingCountry;
        @TestVisible
        private String searchMailingState;
        @TestVisible
        private String searchRegion;
        @TestVisible
        private Boolean searchAttendance;
        @TestVisible
        private Boolean searchSponsorCheck;
        @TestVisible
        private Boolean searchContWebSiteCheck;
        @TestVisible
        private Boolean searchPublicationCheck;
        @TestVisible
        private Boolean searchDirectedConfCheck;
        @TestVisible
        private Boolean searchLeadConfCheck;
        @TestVisible
        private String searchPersonType;
        @TestVisible
        private String searchPrimaryExpertise;
        @TestVisible
        private Boolean filterEvalExc;
        @TestVisible
        private Boolean filterEvalAbove;
        @TestVisible
        private Boolean filterEvalWithin;
        @TestVisible
        private Boolean filterEvalProm;
        @TestVisible
        private Boolean filterEvalBelow;
        @TestVisible
        private Boolean filterEvalDisruptive;
        @TestVisible
        private Boolean searchLeads;
        @TestVisible
        private String searchKeyword;
		@TestVisible
        private Boolean isRecentlyActive;
        @TestVisible
        private String numActiveYears;
        @TestVisible
        private String sortField;
        @TestVisible
        private Boolean isAsc;
        @TestVisible
        private Integer offsetCount;
        @TestVisible
        private Integer queryLimit;
    }
    
}