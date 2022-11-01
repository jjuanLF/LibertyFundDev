import { LightningElement } from "lwc";

export default class DynamicListDisplay extends LightningElement {
	handleRowAction(event) {
		const actionName = event.detail.action.name;
		const row = event.detail.row;
	}
}
