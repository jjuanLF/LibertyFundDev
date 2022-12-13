import { LightningElement, api, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { deleteRecord } from "lightning/uiRecordApi";

export default class FormGenerator extends LightningElement {
    @api objectName;
    @api record;
    @api fields;
    @api add;
    @track show;
    @track formElements;

    connectedCallback() {
        if (this.record) {
            this.formElements = this.generateFormElements();
            this.show = this.add;
        }
    }

    generateFormElements() {
        let formElements = [];

        for (let i = 0; i < this.fields.length; i++) {
            formElements.push({
                field: this.fields[i],
                value: this.record[this.fields[i]],
                id: i
            });
        }

        return formElements;
    }

    handleOnSuccess(event) {
        const closeModal = new CustomEvent("transactioncomplete", { detail: { close: true, success: this.success } });
        this.dispatchEvent(closeModal);
        this.show = false;
    }

    async deleteRecord(event) {
        await deleteRecord(event.target.value);
        this.handleOnSuccess(null);
    }

    close(event) {
        this.show = false;
        this.handleOnSuccess(null);
    }

    onSaveSuccess(event) {
        this.showToast("Success", "Saved successfully!", "success");
    }

    onSaveError(event) {
        this.showToast("Error", event.detail, "error");
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}
