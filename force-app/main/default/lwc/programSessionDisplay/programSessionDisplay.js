import { LightningElement, api, track, wire } from "lwc";
import { refreshApex } from "@salesforce/apex";
import { getRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getProgramSession from "@salesforce/apex/DisplayController.getProgramSession";
import finishSession from "@salesforce/apex/DisplayController.finishSession";

const STAGEVALUE = "Proposed Co-Sponsor Project";
const SUBSTAGEVALUE = "Project - Initiated";
export default class ProgramSessionDisplay extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track renderLWC;
    @track records;
    parentObjectName = "ProgramSession__c";
    childObjectNames = ["ProgramSessionReading__c"];
    layouts = ["ProgramSession__c-Program Session Layout", "ProgramSessionReading__c-Program Session Reading Layout"];
    columns = 2;
    excludeFields = ["ProgramId__c", "CreatedById", "LastModifiedById", "ProgramSessionId__c"];
    error;
    _wiredProgramSession;
    showSessionButton;

    @wire(getProgramSession, { id: "$recordId" })
    programSession(result) {
        this._wiredProgramSession = result;
        if (result.data) {
            this.records = result.data;
            this.renderLWC = false;
        }
        if (result.error) {
            this.error = result.error;
        }
    }

    @wire(getRecord, { recordId: "$recordId", fields: ["Program__c.Stage__c", "Program__c.SubStage__c"] })
    recordInfo(result) {
        if (
            result.data?.fields.Stage__c.value == STAGEVALUE &&
            result.data?.fields.SubStage__c.value == SUBSTAGEVALUE
        ) {
            this.showSessionButton = true;
        }
    }

    renderedCallback() {
        this.renderLWC = true;
    }

    onTransactionComplete(event) {
        if (event.detail.refresh) {
            refreshApex(this._wiredProgramSession);
        }
    }

    async finishSession(event) {
        const response = await finishSession({ id: this.recordId });

        this.dispatchEvent(
            new ShowToastEvent({
                title: response ? "Success" : "Error",
                message: response
                    ? "The program admin has been notified that you have finished adding sessions"
                    : "There's been an error emailing the program admin",
                variant: response ? "success" : "error"
            })
        );
    }
}
