({
    formPress: function(component, event, helper) {
        if (event.keyCode === 13) {
            
            var searchField = component.find("searchField");
            
            component.set("v.selectedTabsort", 'Name_Sort_Key__c');
            component.set("v.previousTabsort", 'Name_Sort_Key__c');
            component.set("v.isAsc", true);
            component.set("v.arrowDirection", 'arrowup');
            
            var searchParams = {
                page : 1,
                pageSize : component.find("pageSize").get("v.value"),
                //searchField : component.find("searchField"),
                isValueMissing : searchField.get("v.validity").valueMissing,
                searchwithName : component.get("v.ischeckBoolean"),
                SearchLow : component.get("v.isConferencesAttendLow"),
                Searchhigh : component.get("v.isConferencesAttendHigh"),
                searchMailingCountry : component.get("v.MailingCountry"),
                searchMailingState : component.get("v.MailingState"),
                searchRegion : component.get("v.Region"),
                searchAttendence : component.get("v.isAttendConfCheck"),
                searchSponsorCheck : component.get("v.isAttendCoSponsorCheck"),
                searchContWebSitecheck : component.get("v.isContWebsitecheck"),
                searchpublicationcheck : component.get("v.ispublicationcheck"),
                searchDirectedConfcheck : component.get("v.isDirectedConfcheck"),
                searchLedConfcheck : component.get("v.isLedConfcheck"),
                searchPersonType : component.get("v.PersonTypeselected"),
                searchPrimaryExpertise : component.get("v.Expertiseselected"),
                searchSource : component.get("v.Source"),
                filterEvalExc : component.get("v.isEvalExcCheck"),
                filterEvalAbove : component.get("v.isEvalAboveCheck"),
                filterEvalWithin : component.get("v.isEvalWithinCheck"),
                filterEvalProm : component.get("v.isEvalPromCheck"),
                filterEvalBelow : component.get("v.isEvalBelowCheck"),
                filterEvalDisruptive : component.get("v.isEvalDisruptiveCheck"),
                searchLeads : component.get("v.useLeads"),
                searchKeyword : component.get("v.searchKeyword"),
                isRecentlyActive : component.get("v.isRecentlyActive"),
                numActiveYears : component.get("v.numActiveYears"),
                isAsc : component.get("v.isAsc"),
                sortField : component.get("v.selectedTabsort")
            };
            
            helper.SearchHelper(component, event,searchParams);
            
            //helper.submitForm(component);
        }
        //$A.log(event);
    },
    
    Search: function(component, event, helper) {
        var searchField = component.find("searchField");
        
        component.set("v.selectedTabsort", 'Name_Sort_Key__c');
        component.set("v.previousTabsort", 'Name_Sort_Key__c');
        component.set("v.isAsc", true);
        component.set("v.arrowDirection", 'arrowup');
        
        var searchParams = {
            page : 1,
            pageSize : component.find("pageSize").get("v.value"),
            //searchField : component.find("searchField"),
            isValueMissing : searchField.get("v.validity").valueMissing,
            searchwithName : component.get("v.ischeckBoolean"),
            SearchLow : component.get("v.isConferencesAttendLow"),
            Searchhigh : component.get("v.isConferencesAttendHigh"),
            searchMailingCountry : component.get("v.MailingCountry"),
            searchMailingState : component.get("v.MailingState"),
            searchRegion : component.get("v.Region"),
            searchAttendence : component.get("v.isAttendConfCheck"),
            searchSponsorCheck : component.get("v.isAttendCoSponsorCheck"),
            searchContWebSitecheck : component.get("v.isContWebsitecheck"),
            searchpublicationcheck : component.get("v.ispublicationcheck"),
            searchDirectedConfcheck : component.get("v.isDirectedConfcheck"),
            searchLedConfcheck : component.get("v.isLedConfcheck"),
            searchPersonType : component.get("v.PersonTypeselected"),
            searchPrimaryExpertise : component.get("v.Expertiseselected"),
            searchSource : component.get("v.Source"),
            filterEvalExc : component.get("v.isEvalExcCheck"),
            filterEvalAbove : component.get("v.isEvalAboveCheck"),
            filterEvalWithin : component.get("v.isEvalWithinCheck"),
            filterEvalProm : component.get("v.isEvalPromCheck"),
            filterEvalBelow : component.get("v.isEvalBelowCheck"),
            filterEvalDisruptive : component.get("v.isEvalDisruptiveCheck"),
            searchLeads : component.get("v.useLeads"),
            searchKeyword : component.get("v.searchKeyword"),
            isRecentlyActive : component.get("v.isRecentlyActive"),
            numActiveYears : component.get("v.numActiveYears"),
            isAsc : component.get("v.isAsc"),
            sortField : component.get("v.selectedTabsort")
        };
        
        helper.SearchHelper(component, event,searchParams);
    },
    
    sortFirstName: function(component, event, helper) {
        component.set("v.previousTabsort", component.get("v.selectedTabsort"));
        component.set("v.selectedTabsort", 'Name_Sort_Key__c');
        helper.sortHelper(component, event); 
    },
    
    sortTotalConf: function(component, event, helper) {
        component.set("v.previousTabsort", component.get("v.selectedTabsort"));
        component.set("v.selectedTabsort", 'Total_Conferences_Attended__c');
        helper.sortHelper(component, event); 
    },
    
    sortConfAttended: function(component, event, helper) {
        component.set("v.previousTabsort", component.get("v.selectedTabsort"));
        component.set("v.selectedTabsort", 'Conferences_Attended_Past_Year__c');
        helper.sortHelper(component, event); 
    },
    
    sortFutureConf: function(component, event, helper) {
        component.set("v.previousTabsort", component.get("v.selectedTabsort"));
        component.set("v.selectedTabsort", 'Future_Conferences__c');
        helper.sortHelper(component, event); 
    },
    
    sortPrimaryExpertise: function(component, event, helper) {
        component.set("v.previousTabsort", component.get("v.selectedTabsort"));
        component.set("v.selectedTabsort", 'Primary_Expertise__c');
        helper.sortHelper(component, event); 
    },
    
    sortMostRecent: function(component, event, helper) {
        component.set("v.previousTabsort", component.get("v.selectedTabsort"));
        component.set("v.selectedTabsort", 'Most_Recent_Attended_Date__c');
        helper.sortHelper(component, event); 
    },
    
    sortAffiliation: function(component, event, helper) {
        component.set("v.previousTabsort", component.get("v.selectedTabsort"));
        component.set("v.selectedTabsort", 'npsp__Primary_Affiliation__r.Name');
        helper.sortHelper(component, event); 
    },
    
    sortTMapInd: function(component, event, helper) {
        component.set("v.previousTabsort", component.get("v.selectedTabsort"));
        component.set("v.selectedTabsort", 'TMap_Indicator__c');
        helper.sortHelper(component, event); 
    },
    
    // navigate to a new record detail page, opening a new tab
    navigateToRecord:function(component,event, helper){
        var recId =event.currentTarget.getAttribute("data-Id");
        var navService = component.find("navService");
        var pageReference = {    
            "type": "standard__recordPage", //example for opening a record page, see bottom for other supported types
            "attributes": {
                "recordId": recId, //place your record id here that you wish to open
                "actionName": "view"
            }
        }
        navService.generateUrl(pageReference)
        .then($A.getCallback(function(url) {
            window.open(url,'_blank'); //this opens your page in a seperate tab here
        }), 
              $A.getCallback(function(error) {
                  console.log('error: ' + error);
              }));
        //	    var navEvent = $A.get("e.force:navigateToSObject");
        //        navEvent.setParams({
        //            recordId:recId,
        //            slideDevName: "detail"
        //        });
        //        navEvent.fire(); 
    },
    
    onSelectChange: function(component, event, helper) {
        helper.sortHelper(component, event); 
    },
    
    getPersonType: function(component, event, helper) { 
        var searchField = component.find('searchField');  
        var searchAttendence=component.get("v.isAttendConfCheck");  	      
        var searchPersonType = event.getParam("value");
        component.set("v.PersonTypeselected", searchPersonType); 
    },
    
    getExpertise: function(component, event, helper) { 
        var searchExpertise = event.getParam("value");
        component.set("v.Expertiseselected", searchExpertise); 
    },
    
    getRegion: function(component, event, helper) { 
        var searchRegion = event.getParam("value");
        component.set("v.Region", searchRegion); 
    },
    
    loadOptions: function (component, event, helper) {
        var options = [
            {value: "", label: ""},
            {value: "Academic", label: "Academic"},
            {value: "Professional", label: "Professional"},
            {value: "Student", label: "Student"},
            {value: "LF", label: "Liberty Fund"},
            {value: "Unassigned", label: "Unassigned"}
        ];
        component.set("v.statusOptions", options);
        
        var regoptions = [
            {value: "", label: ""},
            {value: "North America", label: "North America"},
            {value: "Latin America", label: "Latin America"},
            {value: "Europe", label: "Europe"},
            {value: "Africa", label: "Africa"},
            {value: "Middle East", label: "Middle East"},
            {value: "Australia", label: "Australia"},
            {value: "Asia", label: "Asia"}
        ];
        component.set("v.regionOptions", regoptions);
        
        var expoptions = [
            {value: "", label: ""},
            {value: "Anthropology", label: "Anthropology"},
            {value: "BioEthics", label: "BioEthics"},
            {value: "Business", label: "Business"},
            {value: "Classics", label: "Classics"},
            {value: "Economics", label: "Economics"},
            {value: "Education", label: "Education"},
            {value: "Government", label: "Government"},
            {value: "History", label: "History"},
            {value: "Intl Relations", label: "Intl Relations"},
            {value: "Journalism/Media", label: "Journalism/Media"},
            {value: "Language", label: "Language"},
            {value: "Law", label: "Law"},
            {value: "Literature", label: "Literature"},
            {value: "Mathematics", label: "Mathematics"},
            {value: "Medical", label: "Medical"},
            {value: "Music/Art/Culture", label: "Music/Art/Culture"},
            {value: "Philosophy", label: "Philosophy"},
            {value: "Psychology", label: "Psychology"},
            {value: "Public Intellectual", label: "Public Intellectual"},
            {value: "Public Policy", label: "Public Policy"},
            {value: "Science", label: "Science"},
            {value: "Social/Pol Thought", label: "Social/Pol Thought"},
            {value: "Sociology", label: "Sociology"},
            {value: "Technology", label: "Technology"},
            {value: "Theology", label: "Theology"}
        ];
        component.set("v.expertiseOptions", expoptions);
    },
    
    handleNext: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        pageNumber++;
        helper.pagingHelper(component, event,pageNumber); 
    },
    
    handlePrev: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        pageNumber--;
        helper.pagingHelper(component, event,pageNumber); 
    },
    
    handleSearchTooltipToggle: function(component, event, helper) {
        var nameToggle = component.get("v.searchToggle");
        if(nameToggle == true ) {
            component.set("v.searchToggle", false);
        }else{         
            component.set("v.searchToggle", true);
        }
    }
})