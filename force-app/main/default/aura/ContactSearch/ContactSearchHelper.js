({
    SearchHelper: function(component, event, searchParams) {
        // show spinner message
        component.find("Id_spinner").set("v.class" , 'slds-show');
        var action = component.get("c.fetchContact");
        action.setParams({
            searchParamsJSON : JSON.stringify(searchParams)
        });
        action.setCallback(this, function(response) {
           // hide spinner when response coming from server 
            component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                // if storeResponse size is 0 ,display no record found message on screen.
                if (storeResponse.length == 0) {
                    component.set("v.Message", true);
                } else {
                    component.set("v.Message", false);
                }
                
                // set numberOfRecord attribute value with length of return value from server
                component.set("v.TotalNumberOfRecord", storeResponse.resultList.length);
                
                // set searchResult list with return value from server.
                component.set("v.searchResult", storeResponse.resultList);
                component.set("v.PageNumber", storeResponse.pageNumber);
                component.set("v.TotalRecords", storeResponse.totalRecords);
                component.set("v.RecordStart", storeResponse.recordStart);
                component.set("v.RecordEnd", storeResponse.recordEnd);
                component.set("v.TotalPages", Math.ceil(storeResponse.totalRecords / searchParams.pageSize));
                
            }else if (state === "INCOMPLETE") {
                alert('Response is Incompleted');
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },

    pagingHelper: function(component, event, newPageNum) {
        var searchField = component.find("searchField");
        var searchParams = {
            page : newPageNum,
            pageSize : component.find("pageSize").get("v.value"),
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
            isAsc : component.get("v.isAsc"),
            sortField : component.get("v.selectedTabsort"),
            searchField : "None"
        };
      this.SearchHelper(component, event, searchParams);
    },
    
    sortHelper: function(component, event, searchParams) {
        var searchField = component.find("searchField");
        
        var currentSort = component.get("v.selectedTabsort");
        var prevSort = component.get("v.previousTabsort");
        var currentDir = component.get("v.arrowDirection");
        if (currentSort == prevSort) {
            if (currentDir == 'arrowdown') {
                component.set("v.arrowDirection", 'arrowup');
                component.set("v.isAsc", true);
            } else {
                component.set("v.arrowDirection", 'arrowdown');
                component.set("v.isAsc", false);
            }
        } else {
            component.set("v.arrowDirection", 'arrowup');
            component.set("v.isAsc", true);
        }
        
        var searchParams = {
            page : 1,
            pageSize : component.find("pageSize").get("v.value"),
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
            sortField : component.get("v.selectedTabsort"),
            searchField : "None"
        };

      this.SearchHelper(component, event, searchParams);
   },    
})