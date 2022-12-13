import { LightningElement, api, track, wire } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
import getUserInfo from "@salesforce/apex/DisplayController.getUserInfo";

const LFREPPROFILE = "LF Rep";
const SUBSTAGEVALUE = "Exploratory - Rep";
const FIELDS = [
    "Program__c.ProposedCityCountry__c",
    "Program__c.ProposedTimeline__c",
    "Program__c.ProposedDate__c",
    "Program__c.SubStage__c"
];
export default class ProgramPath extends LightningElement {
    @api objectApiName;
    @api recordId;
    @track show;
    @wire(getUserInfo)
    userInfo;

    @wire(getRecord, {
        recordId: "$recordId",
        fields: FIELDS
    })
    programRecord({ data, error }) {
        if (data) {
            if (
                (data.fields.ProposedCityCountry__c.value == null ||
                    data.fields.ProposedTimeline__c.value == null ||
                    data.fields.ProposedDate__c.value == null) &&
                this.userInfo.data.Profile.Name == LFREPPROFILE &&
                data.fields.SubStage__c.value == SUBSTAGEVALUE
            ) {
                this.show = true;
            }
        }
    }

    get inputVariables() {
        return [{ name: "recordId", type: "String", value: this.recordId }];
    }

    handleStatusChange(event) {
        if (event.detail.status === "FINISHED") {
            this.show = false;
        }
    }
}
