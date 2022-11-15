import { LightningElement, api, track, wire } from "lwc";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { getRecords } from "lightning/uiRecordApi";

export default class FormGenerator extends LightningElement {
    @api objectName;
    @api fields;
    @api numberColumns;
    @api records;

    @track formFields;
    @track objectInfo;

    @wire(getObjectInfo, { objectApiName: "$objectName" }) objectInfo;

    generateFormData() {}
}
