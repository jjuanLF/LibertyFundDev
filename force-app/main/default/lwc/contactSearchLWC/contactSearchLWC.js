import { LightningElement } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import personSearchController from '@salesforce/apex/ContactSearchCntlr.fetchContact';
import {
    personTypeOptions,
    primaryExpertiseOptions,
    regionOptions,
    columns
} from './constants';
import { NavigationMixin } from 'lightning/navigation';

export default class ContactSearchLWC extends NavigationMixin(LightningElement) {
    queryResults;
    isLoading = false;
    activeSections = ['resultFilters'];
    keywords = '';
    searchByName = false;
    searchByLeads = false;
    personTypeOptions = personTypeOptions();
    personType = '';
    primaryExpertiseOptions = primaryExpertiseOptions();
    primaryExpertise = '';
    source = '';
    minCoreConf;
    maxCoreConf;
    country = '';
    state = '';
    regionOptions = regionOptions();
    region = '';
    coreNetwork = false;
    cospoNetwork = false;
    webContributor = false;
    bookEditorAuthor = false;
    confDirector = false;
    confDiscLead = false;
    activeLastYears = false;
    numYearsActive;
    evalExceptional = false;
    evalAboveExp = false;
    evalWithinExp = false;
    evalPromising = false;
    evalBelowExp = false;
    evalDisruptive = false;
    columns = columns();
    datatableData = [];
    sortedBy = 'recordURL';
    sortDirection = 'asc';
    defaultSortDirection = 'asc';
    totalNumberOfRows = 2000;
    loadMoreOffSet = 20;
    offsetCount = 0;
    loadMoreStatus;
    targetDatatable;
    searchHasRun = false;
    queryResultCount = 0;
    selectedIds;
    listSelectedRecords;

    ///Methods
    handleChange(event) {
        var value;
        if (
            event.target.type === 'checkbox' ||
            event.target.type === 'checkbox-button' ||
            event.target.type === 'toggle'
        ) {
            value = event.target.checked;
        } else {
            value = event.target.value;
        }

        switch (event.target.dataset.id) {
            case 'keywords':
                this.keywords = value;
                break;
            case 'searchByName':
                this.searchByName = value;
                break;
            case 'searchByLeads':
                this.searchByLeads = value;
                break;
            case 'personType':
                this.personType = value;
                break;
            case 'primaryExpertise':
                this.primaryExpertise = value;
                break;
            case 'source':
                this.source = value;
                break;
            case 'minCoreConf':
                this.minCoreConf = value;
                break;
            case 'maxCoreConf':
                this.maxCoreConf = value;
                break;
            case 'country':
                this.country = value;
                break;
            case 'state':
                this.state = value;
                break;
            case 'region':
                this.region = value;
                break;
            case 'coreNetwork':
                this.coreNetwork = value;
                break;
            case 'cospoNetwork':
                this.cospoNetwork = value;
                break;
            case 'webContributor':
                this.webContributor = value;
                break;
            case 'bookEditorAuthor':
                this.bookEditorAuthor = value;
                break;
            case 'confDirector':
                this.confDirector = value;
                break;
            case 'confDiscLead':
                this.confDiscLead = value;
                break;
            case 'activeLastYears':
                this.activeLastYears = value;
                break;
            case 'numYearsActive':
                this.numYearsActive = value;
                break;
            case 'evalExceptional':
                this.evalExceptional = value;
                break;
            case 'evalAboveExp':
                this.evalAboveExp = value;
                break;
            case 'evalWithinExp':
                this.evalWithinExp = value;
                break;
            case 'evalPromising':
                this.evalPromising = value;
                break;
            case 'evalBelowExp':
                this.evalBelowExp = value;
                break;
            case 'evalDisruptive':
                this.evalDisruptive = value;
                break;
            default:
                break;
        }
    }

    getRecords(searchParams) {
        personSearchController({
            searchParamsJSON: JSON.stringify(searchParams)
        })
            .then((result) => {
                result = JSON.parse(JSON.stringify(result));
                this.queryResults = result.resultList.map((obj) => {
                    return this.enrichData(obj);
                });
                this.queryResultCount = result.totalRecords;
                this.totalNumberOfRows =
                    result.totalRecords < this.totalNumberOfRows
                        ? result.totalRecords
                        : this.totalNumberOfRows;
                this.datatableData = this.datatableData.concat(
                    this.queryResults
                );

                this.loadMoreStatus = '';
                this.isLoading = false; //on Search

                if (
                    this.targetDatatable &&
                    this.datatableData.length >= this.totalNumberOfRows
                ) {
                    //this.targetDatatable.enableInfiniteLoading = false;
                    if (this.totalNumberOfRows == 2000) {
                        this.loadMoreStatus =
                            'You can only load 2000 search results. To see more, refine your filters for a more specific search.';
                    } else if (this.totalNumberOfRows == 0) {
                        this.loadMoreStatus = 'Your search returned no results';
                    } else {
                        this.loadMoreStatus = 'No more records to load';
                    }
                }
                if (this.targetDatatable) {
                    this.targetDatatable.isLoading = false; //on Load More
                }
            })
            .catch((error) => {
                console.log('error : ' + JSON.stringify(error));
                this.loadMoreStatus = '';
                this.isLoading = false; //on Search
                this.targetDatatable.isLoading = false; //infinite scroll
            });
    }

    enrichData(obj) {
        obj.recordURL = '/' + obj.recordId;
        if (
            obj.evaluationImage !== undefined &&
            obj.evaluationImage.includes('Exceptional/Above Exp')
        ) {
            obj.expAboveExp = 'utility:check'; //'utility:like';
        }
        if (
            obj.evaluationImage !== undefined &&
            obj.evaluationImage.includes('Promising')
        ) {
            obj.expPromising = 'utility:light_bulb';
        }
        if (
            obj.evaluationImage !== undefined &&
            obj.evaluationImage.includes('Inactive')
        ) {
            obj.isInactive = 'utility:ban'; //'utility:resource_absence';
        }
        if (
            obj.evaluationImage !== undefined &&
            obj.evaluationImage.includes('Deceased')
        ) {
            obj.isDeceased = 'utility:clear'; //'utility:block_visitor';
        }
        if (obj.tMapImage !== undefined && obj.tMapImage.includes('TMap')) {
            obj.hasTMap = 'utility:metrics';
        }
        if (
            obj.resultIndicator !== undefined &&
            obj.resultIndicator.includes('L')
        ) {
            obj.typeIndicator = 'utility:target';
            obj.typeTitle = 'Lead';
        } else if (
            obj.resultIndicator !== undefined &&
            obj.resultIndicator.includes('C')
        ) {
            obj.typeIndicator = 'utility:user';
            obj.typeTitle = 'Contact';
        }
        return obj;
    }

    generateSearchPayload() {
        return {
            //page: 1,
            //pageSize: 25,
            //isValueMissing : false,
            isAsc: true,
            sortField: 'LastName',
            searchKeyword: this.keywords,
            searchWithName: this.searchByName,
            searchLeads: this.searchByLeads,
            searchPersonType: this.personType,
            searchPrimaryExpertise: this.primaryExpertise,
            searchSource: this.source,
            SearchLow: this.minCoreConf,
            SearchHigh: this.maxCoreConf,
            searchMailingCountry: this.country,
            searchMailingState: this.state,
            searchRegion: this.region,
            searchAttendance: this.coreNetwork,
            searchSponsorCheck: this.cospoNetwork,
            searchContWebSiteCheck: this.webContributor,
            searchPublicationCheck: this.bookEditorAuthor,
            searchDirectedConfCheck: this.confDirector,
            searchLeadConfCheck: this.confDiscLead,
            isRecentlyActive: this.activeLastYears,
            numActiveYears: this.numYearsActive,
            filterEvalExc: this.evalExceptional,
            filterEvalAbove: this.evalAboveExp,
            filterEvalWithin: this.evalWithinExp,
            filterEvalProm: this.evalPromising,
            filterEvalBelow: this.evalBelowExp,
            filterEvalDisruptive: this.evalDisruptive,
            offsetCount: this.offsetCount,
            queryLimit: this.loadMoreOffSet
        };
    }

    doSearch(event) {
        if ((this.searchHasRun = false)) {
            this.searchHasRun = true;
        } else {
            this.doSoftReset();
            refreshApex(this.datatableData);
        }
        this.isLoading = true;
        this.loadMoreStatus = 'Loading';
        this.activeSections = ['results'];
        this.getRecords(this.generateSearchPayload());
    }

    handleKeyUp(event) {
        const isEnterKey = event.keyCode === 13;
        if (isEnterKey) {
            this.keywords = event.target.value;
            this.doSearch();
        }
    }

    doSoftReset() {
        this.queryResults = [];
        this.datatableData = [];
        this.targetDatatable = [];
        this.datatableData.totalRecords = 0;
        this.totalNumberOfRows = 2000;
        this.offsetCount = 0;
        //this.targetDatatable.enableInfiniteLoading = true;
        //this.datatableData.enableInfiniteLoading = true;
        this.sortedBy = 'recordURL';
        this.sortDirection = 'asc';
    }

    doSearchReset(event) {
        this.doSoftReset();
        this.searchHasRun = false;
        this.activeSections = ['resultFilters'];
        this.template.querySelectorAll('lightning-input').forEach((element) => {
            if (
                element.type === 'checkbox' ||
                element.type === 'checkbox-button' ||
                element.type === 'toggle'
            ) {
                element.checked = false;
            /*} else if (
                element.type === 'number' &&
                element.name != 'minCoreConf'
            ) {
                element.value = 100;
            } else if (
                element.type === 'number' &&
                element.name === 'minCoreConf'
            ) {
                element.value = 0;*/
            } else if (
                element.type === 'number'
            ) {
                element.value = '';
            } else {
                element.value = '';
            }
        });
        return refreshApex(this.datatableData);
    }

    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.datatableData];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.datatableData = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }

    sortBy(field, reverse, primer) {
        field = field == 'recordURL' ? 'recordName' : field;
        const key = primer
            ? function (x) {
                return primer(x[field]);
            }
            : function (x) {
                return x[field];
            };

        return function (a, b) {
            a = key(a);
            b = key(b);
            if (a == null) {
                return 1;
            } else if (b == null) {
                return -1;
            } else {
                return reverse * ((a > b) - (b > a));
            }
        };
    }

    loadMoreData(event) {
        if (this.datatableData.totalRecords >= this.totalNumberOfRows) {
            // do nothing
        } else {
            this.offsetCount = this.offsetCount + this.loadMoreOffSet;
            //event.target.enableInfiniteLoading = true;
            event.target.isLoading = true;
            this.targetDatatable = event.target;
            this.loadMoreStatus = 'Loading';
            this.getRecords(this.generateSearchPayload());
        }
        //Had problems with enableInfiniteLoading - but how to stop table from trying to reload?
        //Why isn't totalRecords updating with new result total if search updated (soft reset)?
    }

    getSelectedRows() {
        var selectedRecords = this.template
            .querySelector('lightning-datatable')
            .getSelectedRows();
        if (selectedRecords.length > 0) {
            console.log('selectedRecords are ', selectedRecords);
            let recordIds = selectedRecords.map((currentRecord) => {
                return currentRecord.recordId;
            })
            let ids = recordIds.join(', ');
            this.selectedIds = ids.replace(/^,/, '');
            this.listSelectedRecords = selectedRecords;
        }
    }

    //flows cannot receive collection variables via url. Need to pass in ids as string, then parse into Id collection in flow.
    invokeFlowSuggestConferees() {
        this.getSelectedRows();
        if (this.selectedIds.length > 0) {
            this[NavigationMixin.GenerateUrl]({
                type: 'standard__webPage',
                attributes: {
                    url: '/flow/Send_Suggested_Leads_Contacts_to_Campaign_v3?listViewSource=contact&retURL=/003/o&ids=' +this.selectedIds
                },
                state: {
                    ids: this.selectedIds
                }
            }).then(generatedUrl => {
                window.open(generatedUrl, '_blank');
            });
        }
    }
    
    // invokeFlowAddTopic(){
    //     this.getSelectedRows();
    //     if (this.selectedIds.length > 0) {
    //         this[NavigationMixin.GenerateUrl]({
    //             type: 'standard__webPage',
    //             attributes: {
    //                 url: '/flow/Send_Suggested_Leads_Contacts_to_Campaign_v3?listViewSource=contact&retURL=/003/o&ids=' +this.selectedIds
    //             },
    //             state: {
    //                 ids: this.selectedIds
    //             }
    //         }).then(generatedUrl => {
    //             window.open(generatedUrl, '_blank');
    //         });
    //     }
    // }
    
    invokeFlowRequestMerge(){
        this.getSelectedRows();
        if (this.selectedIds.length > 0) {
            this[NavigationMixin.GenerateUrl]({
                type: 'standard__webPage',
                attributes: {
                    url: '/flow/Request_Duplicate_Review?retURL=/003/o&ids=' +this.selectedIds
                },
                state: {
                    ids: this.selectedIds
                }
            }).then(generatedUrl => {
                window.open(generatedUrl, '_blank');
            });
        }
    }
}