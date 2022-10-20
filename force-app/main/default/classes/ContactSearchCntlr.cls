public with sharing class ContactSearchCntlr {
    Integer totalRecords;
    @AuraEnabled
    public static ContactDataTableWrapper fetchContact(
        String searchParamsJSON
    ) {
        system.debug('searchParamsJSON: ' + searchParamsJSON);
        System.debug('#### ' + JSON.deserializeUntyped(searchParamsJSON));

        //Init ServerRequest
        searchParamsRequest req = new searchParamsRequest();
        req = (searchParamsRequest) JSON.deserialize(
            searchParamsJSON,
            searchParamsRequest.class
        );
        system.debug('offset param: ' + req.offsetCount);

        ContactDataTableWrapper objDT = new ContactDataTableWrapper();

        Integer offset = req.offsetCount;
        Integer queryLimit = req.queryLimit;
        //Integer offset = (req.page - 1) * req.pageSize;
        //Integer recordEnd = req.pageSize * req.page;
        objDT.pageSize = req.pageSize;
        objDT.pageNumber = req.page;
        objDT.recordStart = offset + 1;

        Boolean isKeywordSearch = (req.searchKeyword != '' &&
        req.searchKeyword != null); // handy Boolean on whether this is a keyword search
        Boolean skipSOQLSearch = false; // Boolean if a Keyword search returns no records

        List<SearchResultLine> lSRL = new List<SearchResultLine>(); // list of search result lines, used for both Lead and Contact searches

        // retrieve custom search settings
        Boolean bExcludeConvertedLeads = true; // if custom metadata not configured, default to exluding converted leads in search results
        List<Liberty_Fund_Search_Settings__mdt> searchSettings = [
            SELECT Exclude_Converted_Leads__c
            FROM Liberty_Fund_Search_Settings__mdt
            LIMIT 1
        ];
        system.debug('#### line 35');
        if (searchSettings.size() > 0) {
            bExcludeConvertedLeads = searchSettings[0]
                .Exclude_Converted_Leads__c;
        }

        //*************************************************************************************************************** LEAD SEARCH
        if (req.searchLeads) {
            //searching Leads
            List<List<Sobject>> leadSearchList;
            List<Lead> leadList = new List<Lead>();
            List<TMap_Data__c> tmapList = new List<TMap_Data__c>();
            Set<Id> leadIds = new Set<Id>();

            if (isKeywordSearch) {
                leadSearchList = [
                    FIND :req.searchKeyWord
                    IN ALL FIELDS
                    RETURNING Lead(Id), TMAP_Data__c(Lead__c)
                ];
                tmapList = leadSearchList[1];
                for (TMap_Data__c oTMAP : tmapList) {
                    leadIds.add(oTMAP.Lead__c);
                }
                leadList = leadSearchList[0];
                for (Lead l : leadList) {
                    leadIds.add(l.id);
                }
                if (leadIds.size() == 0) {
                    skipSOQLSearch = true;
                }
            }

            if (!skipSOQLSearch) {
                list<Lead> leadFinal = new List<Lead>();
                string querystr = '';
                querystr = 'SELECT id,FirstName,LastName,Name,Region__c,Company,City,State,Country,Name_Sort_Key__c,TMap_Image__c FROM Lead WHERE ';
                if (req.searchWithName) {
                    querystr +=
                        'Name like ' +
                        '\'%' +
                        req.searchKeyWord +
                        '%\' AND';
                }
                if (
                    req.searchMailingCountry != null &&
                    req.searchMailingCountry != ''
                )
                    querystr +=
                        '  Country like ' +
                        '\'%' +
                        req.searchMailingCountry +
                        '%\' AND';
                if (req.searchMailingState != null &&
                    req.searchMailingState != '')
                    querystr +=
                        '  State like ' +
                        '\'%' +
                        req.searchMailingState +
                        '%\' AND';
                if (req.searchRegion != null && req.searchRegion != '')
                    querystr +=
                        ' Region__c like ' +
                        '\'%' +
                        req.searchRegion +
                        '%\' AND';
                if (bExcludeConvertedLeads)
                    querystr += ' IsConverted=false AND';
                if (isKeywordSearch) {
                    querystr += '  id=:leadIds';
                } else {
                    querystr += '  id !=null';
                }
                system.debug('************** leadIds: ' + leadIds);

                //     if(sortField !='' && sortField !=null && searchKeyWord !='' && searchKeyWord !=null) {
                if (req.sortField != '' && req.sortField != null) {
                    querystr += ' Order By ' + req.sortField;
                    system.debug(':::::QUERY STRING::::' + querystr);
                    if (req.isAsc) {
                        querystr += ' asc NULLS last';
                    } else {
                        querystr += ' desc NULLS last';
                    }
                }

                string querystrbeforelimits = querystr + ' LIMIT 49900'; // Quick & dirty fix, Chris
                querystr += ' LIMIT ' + queryLimit; //req.pageSize;
                querystr += ' OFFSET ' + offset;
                system.debug('##### '+ leadIds);
                system.debug(':::::QUERY STRING 2::::' + querystr);

                // perform the final SOQL query against Contact
                leadFinal = database.query(querystr);

                // consolidate leads into wrapper class
                for (Lead oLead : leadFinal) {
                    SearchResultLine oSRL = new SearchResultLine();

                    oSRL.resultIndicator = 'L';
                    oSRL.recordId = oLead.Id;
                    oSRL.recordName = oLead.Name_Sort_Key__c;
                    oSRL.primaryAffiliation = oLead.Company;
                    oSRL.mailingCity = oLead.City;
                    oSRL.mailingState = oLead.State;
                    oSRL.mailingCountry = oLead.Country;
                    oSRL.tMapImage = oLead.TMap_Image__c;
                    lSRL.add(oSRL);
                }

                Integer totalRecords = database.query(querystrbeforelimits)
                    .Size(); // Quick & dirty fix (using multiple queries) Chris
                //objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                objDT.totalRecords = totalRecords;
            } else {
                // we did a Keyword search and found no records
                //objDT.recordEnd = 0;
                objDT.totalRecords = 0;
            }

            objDt.resultList = lSRL;
            system.debug('objDT>>>' + objDT);

            //*************************************************************************************************************** CONTACT SEARCH
        } else {
            //searching Contacts
            List<Contact> conList = new List<contact>(); // list of Contact records from SOSL
            List<Expertise__c> ExpList = new List<Expertise__c>(); // list of Expertise records from SOSL
            List<Category__c> CatList = new List<Category__c>(); // list of Category records from SOSL
            List<Evaluation__c> EvaList = new List<Evaluation__c>(); // list ofEvaluation records from SOSL
            List<LF_Web_Contributor__c> WebList = new List<LF_Web_Contributor__c>(); // list of LF Web COntributor records from SOSL
            set<id> conids = new Set<id>(); // consolidated list of Contact Ids across all SOSL objects searched

            list<List<Sobject>> contactSearchList;
            if (isKeyWordSearch) {
                contactSearchList = [
                    FIND :req.searchKeyWord
                    IN ALL FIELDS
                    RETURNING
                        Contact(id),
                        Expertise__c(Contact__c),
                        Category__c(Contact__c),
                        Evaluation__c(Contact__c),
                        LF_Web_Contributor__c(Contact__c)
                ];
                conList = contactSearchList[0];
                system.debug('conList>>>' + conList);
                ExpList = contactSearchList[1];
                CatList = contactSearchList[2];
                EvaList = contactSearchList[3];
                WebList = contactSearchList[4];

                for (LF_Web_Contributor__c web : WebList) {
                    conids.add(web.Contact__c);
                }
                for (Expertise__c exp : ExpList) {
                    conids.add(exp.Contact__c);
                }
                for (Category__c cat : CatList) {
                    conids.add(cat.Contact__c);
                }
                for (Evaluation__c eva : EvaList) {
                    conids.add(eva.Contact__c);
                }
                for (Contact c : conList) {
                    conids.add(c.id);
                }
                if (conIds.size() == 0) {
                    skipSOQLSearch = true;
                }
            }

            list<contact> ConFinal = new List<contact>();
            string querystr = '';
            string activeSinceDate;
            if (
                (req.isRecentlyActive == true) &&
                (req.numActiveYears != null) &&
                (integer.valueof(req.numActiveYears) > 0) &&
                (integer.valueof(req.numActiveYears) < 20)
            ) {
                activeSinceDate = system.now()
                    .adddays(-365 * integer.valueof(req.numActiveYears))
                    .format('yyyy-MM-dd');
            }
            string whereSnippet = '';
            querystr = 'select id,FirstName,LastName,Name,CRM_Person_Type__c,Website_Contributor__c,Publication_Editor_Author__c,Count_as_Director__c,Count_as_Disc_Lead__c,Total_Attended_Conferences_Only__c,Total_Attended_CoSpon_Only__c,Region__c,Account.Name,MailingCity,MailingState,MailingCountry,Affiliation__c,Primary_Expertise__c,Total_Conferences_Attended__c,Conferences_Attended_Past_Year__c,Future_Conferences__c,Evaluation_Image__c,Most_Recent_Attended_Date__c,Name_Sort_Key__c,TMap_Image__c from contact where ';
            if (req.searchWithName) {
                querystr += 'Name like ' + '\'%' + req.searchKeyWord + '%\'AND';
            }
            if (req.searchPersonType != '' && req.searchPersonType != 'Any')
                querystr +=
                    '  CRM_Person_Type__c LIKE ' +
                    '\'%' +
                    req.searchPersonType +
                    '%\'AND';
            if (
                req.searchMailingCountry != null &&
                req.searchMailingCountry != ''
            )
                querystr +=
                    '  MailingCountry like ' +
                    '\'%' +
                    req.searchMailingCountry +
                    '%\'AND';
            if (req.searchMailingState != null && req.searchMailingState != '')
                querystr +=
                    '  MailingState like ' +
                    '\'%' +
                    req.searchMailingState +
                    '%\'AND';
            if (req.searchRegion != null && req.searchRegion != '')
                querystr +=
                    ' Region__c like ' +
                    '\'%' +
                    req.searchRegion +
                    '%\'AND';
            if (req.searchAttendance)
                querystr += ' Total_Attended_Conferences_Only__c > 0 AND';
            if (req.searchSponsorCheck)
                querystr += ' Total_Attended_CoSpon_Only__c > 0 AND';
            if (req.searchContWebSiteCheck)
                querystr += ' Website_Contributor__c=true AND';
            if (req.searchPublicationCheck)
                querystr += ' Publication_Editor_Author__c =true AND';
            if (req.searchDirectedConfCheck)
                querystr += ' Count_as_Director__c > 0 AND';
            if (req.searchLeadConfCheck)
                querystr += ' Count_as_Disc_Lead__c > 0 AND';
            if (
                req.searchPrimaryExpertise != '' &&
                req.searchPrimaryExpertise != null
            )
                querystr +=
                    '  Primary_Expertise__c like ' +
                    '\'%' +
                    req.searchPrimaryExpertise +
                    '%\'AND';
            if (req.searchSource != '' && req.searchSource != null)
                querystr +=
                    '  LF_Source__c like ' +
                    '\'%' +
                    req.searchSource +
                    '%\'AND';
            if (
                req.searchLow != null &&
                req.searchLow != '' &&
                req.searchHigh != null &&
                req.searchHigh != ''
            )
                whereSnippet =
                    '  Total_Attended_Conferences_Only__c >= ' +
                    req.searchLow +
                    ' AND ' +
                    ' Total_Attended_Conferences_Only__c <= ' +
                    req.searchHigh +
                    ' AND';
            system.debug('$$$$ ' + whereSnippet);
            querystr += whereSnippet;
            if (req.filterEvalExc)
                querystr += ' Evaluation_Count_Exceptional__c > 0 AND';
            if (req.filterEvalAbove)
                querystr += ' Evaluation_Count_Above_Exp__c > 0 AND';
            if (req.filterEvalWithin)
                querystr += ' Evaluation_Count_Within_Exp__c > 0 AND';
            if (req.filterEvalProm)
                querystr += ' Evaluation_Count_Promising__c > 0 AND';
            if (req.filterEvalBelow)
                querystr += ' Evaluation_Count_Below_Exp__c > 0 AND';
            if (req.filterEvalDisruptive)
                querystr += ' Evaluation_Count_Disruptive__c > 0 AND';
            if (req.isRecentlyActive && activeSinceDate != null)
                querystr +=
                    ' Most_Recent_Attended_Date__c >= ' +
                    activeSinceDate +
                    ' AND';
            if (!skipSOQLSearch) {
                if (conids.size() > 0) {
                    querystr += '  id=:conids';
                } else {
                    querystr += '  id !=null';
                }

                if (req.sortField != '' && req.sortField != null) {
                    querystr += ' Order By ' + req.sortField;
                    system.debug(':::::QUERY STRING::::' + querystr);
                    if (req.isAsc) {
                        querystr += ' asc NULLS last';
                    } else {
                        querystr += ' desc NULLS last';
                    }
                }

                string querystrbeforepaging = querystr + ' LIMIT 49900'; // Quick & dirty fix, Chris
                querystr += ' LIMIT ' + queryLimit; //req.pageSize;
                querystr += ' OFFSET ' + offset;

                system.debug(':::::QUERY STRING 2::::' + querystr);

                // perform the final SOQL query against Contact
                conFinal = database.query(querystr);

                // consolidate contacts into wrapper class
                for (Contact oCon : conFinal) {
                    SearchResultLine oSRL = new SearchResultLine();

                    oSRL.resultIndicator = 'C';
                    oSRL.recordId = oCon.Id;
                    oSRL.recordName = oCon.Name_Sort_Key__c;
                    oSRL.mailingCity = oCon.MailingCity;
                    oSRL.mailingState = oCon.MailingState;
                    oSRL.mailingCountry = oCon.MailingCountry;
                    oSRL.primaryExpertise = oCon.Primary_Expertise__c;
                    oSRL.attendedTotal = oCon.Total_Conferences_Attended__c;
                    oSRL.attendedRecent = oCon.Conferences_Attended_Past_Year__c;
                    oSRL.attendedFuture = oCon.Future_Conferences__c;
                    oSRL.attendedConfTotal = oCon.Total_Attended_Conferences_Only__c;
                    oSRL.attendedCoSponTotal = oCon.Total_Attended_CoSpon_Only__c;
                    oSRL.countDirector = oCon.Count_as_Director__c;
                    oSRL.countDiscLead = oCon.Count_as_Disc_Lead__c;
                    oSRL.evaluationImage = oCon.Evaluation_Image__c;
                    oSRL.mostRecentAttendedDate = oCon.Most_Recent_Attended_Date__c;
                    oSRL.tMapImage = oCon.TMap_Image__c;
                    lSRL.add(oSRL);
                }

                Integer totalRecords = database.query(querystrbeforepaging)
                    .Size(); // Quick & dirty fix (using multiple queries) Chris
                //objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                objDT.totalRecords = totalRecords;
            } else {
                // we did a Keyword search and found no records
                //objDT.recordEnd = 0;
                objDT.totalRecords = 0;
            }

            objDt.resultList = lSRL;
            system.debug('objDT>>>' + objDT);
        }
        return objDT;
    }

    //Class for search result line to be included in ContactDataTableWrapper
    public class SearchResultLine {
        @AuraEnabled
        public String resultIndicator { get; set; }
        @AuraEnabled
        public Id recordId { get; set; }
        @AuraEnabled
        public String recordName { get; set; }
        @AuraEnabled
        public String primaryAffiliation { get; set; }
        @AuraEnabled
        public String mailingCity { get; set; }
        @AuraEnabled
        public String mailingState { get; set; }
        @AuraEnabled
        public String mailingCountry { get; set; }
        @AuraEnabled
        public String primaryExpertise { get; set; }
        @AuraEnabled
        public Decimal attendedTotal { get; set; }
        @AuraEnabled
        public Decimal attendedConfTotal { get; set; }
        @AuraEnabled
        public Decimal attendedCoSponTotal { get; set; }
        @AuraEnabled
        public Decimal attendedRecent { get; set; }
        @AuraEnabled
        public Decimal attendedFuture { get; set; }
        @AuraEnabled
        public Decimal countDirector { get; set; }
        @AuraEnabled
        public Decimal countDiscLead { get; set; }
        @AuraEnabled
        public String evaluationImage { get; set; }
        @AuraEnabled
        public Date mostRecentAttendedDate { get; set; }
        @AuraEnabled
        public String tMapImage { get; set; }
    }

    //Wrapper Class For Contact DataTable
    public class ContactDataTableWrapper {
        @AuraEnabled
        public Integer pageSize { get; set; }
        @AuraEnabled
        public Integer pageNumber { get; set; }
        @AuraEnabled
        public Integer recordStart { get; set; }
        @AuraEnabled
        public List<SearchResultLine> resultList { get; set; }
        @AuraEnabled
        public Integer recordEnd { get; set; }
        @AuraEnabled
        public Integer totalRecords { get; set; }
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
        private Boolean isValueMissing; //deprecated
        @TestVisible
        private Boolean searchWithName;
        @TestVisible
        private String searchLow;
        @TestVisible
        private String searchHigh;
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
        private String searchSource;
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