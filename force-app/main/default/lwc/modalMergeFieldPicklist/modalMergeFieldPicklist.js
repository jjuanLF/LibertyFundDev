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
		if (this.selectedOptions.length > 0) {
			this.success = await setContactToMerge({
				id: this.tempcontactid,
				contactId: this.contactid,
				fieldsToMergeList: this.selectedOptions,
			});
			this.close();
		} else {
			await LightningAlert.open({
				message: "You have not selected any fields to merge",
				theme: "error", // a red theme intended for error states
				label: "Warning!", // this is the header text
			});
		}
	}
}
