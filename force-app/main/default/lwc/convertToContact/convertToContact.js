import { LightningElement, track } from "lwc";
import LightningConfirm from "lightning/confirm";
import convertContact from "@salesforce/apex/ContactStagingController.convertContact";

export default class ConvertToContact extends LightningElement {
	@track created;
	@track updated;
	@track failed;
	@track results;
	processing;

	async handleClick() {
		this.processing = true;
		let results = await convertContact({});

		if (results) {
			this.processing = false;
			this.results = Object.keys(results);
			this.created = results["Created"];
			this.updated = results["Updated"];
			this.failed = results["Failed"];
		}
	}
}
