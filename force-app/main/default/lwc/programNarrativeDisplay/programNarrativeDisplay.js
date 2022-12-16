import { LightningElement, api, track, wire } from "lwc";
import { refreshApex } from "@salesforce/apex";
import getProgramNarrative from "@salesforce/apex/DisplayController.getProgramNarrative";

export default class ProgramNarrativeDisplay extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track renderLWC;
    @track records;
    parentObjectName = "ProgramNarrative__c";
    childObjectNames = [];
    columns = 2;
    excludeFields = ["CreatedById", "LastModifiedById"];
    layouts = ["ProgramNarrative__c-Program Narrative Layout"];
    error;
    _wiredProgramNarrative;

    @wire(getProgramNarrative, { id: "$recordId" })
    programNarrative(result) {
        this._wiredProgramNarrative = result;
        if (result.data) {
            this.records = result.data;
            this.renderLWC = false;
        }
        if (result.error) {
            this.error = result.error;
        }
    }

    renderedCallback() {
        this.renderLWC = true;
    }

    onTransactionComplete(event) {
        if (event.detail.refresh) {
            refreshApex(this._wiredProgramNarrative);
        }
    }
}
