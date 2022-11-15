import { LightningElement, api } from "lwc";
import LightningAlert from "lightning/alert";

import setContactToMerge from "@salesforce/apex/ContactStagingController.setContactToMerge";

export default class ModalMergeFieldPicklist extends LightningElement {
    @api values;
    @api tempcontactid;
    @api contactid;
    @api options;
    success;
    selectedOptions = [];

    close() {
        const closeModal = new CustomEvent("modalevent", { detail: { openModal: false, success: this.success } });
        this.dispatchEvent(closeModal);
    }

    handleChange(event) {
        this.selectedOptions = event.detail.value;
    }

    async mergeContact() {
        let message = "Your merge changes have been successfully saved";
        let warn = false;
        if (this.selectedOptions.length > 0) {
            this.success = await setContactToMerge({
                id: this.tempcontactid,
                contactId: this.contactid,
                fieldsToMergeList: this.selectedOptions
            });

            if (!this.success) {
                warn = true;
                message = "There's been an error processing your changes.  Please notify your administrator";
            }
        } else {
            message = "You have not selected any fields to merge";
            warn = true;
        }
        this.notify(message, warn);

        if (this.success) {
            this.close();
        }
    }

    async notify(message, warn) {
        await LightningAlert.open({
            message: message,
            theme: warn ? "error" : "success", // a red theme intended for error states
            label: warn ? "Warning!" : "FYI" // this is the header text
        });
    }
}
