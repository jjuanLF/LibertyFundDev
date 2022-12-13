import { LightningElement, api, track, wire } from "lwc";
import getPageLayout from "@salesforce/apex/DisplayController.getPageLayout";
import { getObjectInfos } from "lightning/uiObjectInfoApi";
import HelperFunctions from "./helperFunctions";

const CHILDSUFFIX = "__r";

export default class TabGenerator extends LightningElement {
    @api recordsFromSalesforce;
    @api objectApiName;
    @api parentObjectName;
    @api childObjectNames;
    @api layoutsToGet;
    @api recordId;
    @api columns;
    @api excludeFields;
    @track add;
    @track labels = {};
    @track records;
    @track objectApiNames;
    results = {};
    recordset = {};
    layouts;
    activeSection = "";

    @wire(getPageLayout, { pageLayoutList: "$layoutsToGet" })
    pageLayout(result) {
        if (result.data) {
            this.layouts = JSON.parse(result.data);
            this.getFields();
        }
    }

    @wire(getObjectInfos, { objectApiNames: "$objectApiNames" })
    objectInfos(data, error) {
        if (data.data) {
            this.results = data.data.results;
            this.labels = new HelperFunctions().getObjectInfoLabels(data.data.results, this.objectApiNames);
        }
    }

    connectedCallback() {
        if (this.recordsFromSalesforce) {
            this.objectApiNames = [this.objectApiName, this.parentObjectName, ...this?.childObjectNames];
            this.generateRecords();
        }
    }

    generateRecords() {
        this.recordset.objectName = this.parentObjectName;
        this.recordset.fields = [];
        this.recordset.records = [];
        if (this.recordsFromSalesforce) {
            for (let i = 0; i < this.recordsFromSalesforce.length; i++) {
                let record = this.setFieldsandValues(this.recordsFromSalesforce[i]);
                record.children = this.generateChildren(this.recordsFromSalesforce[i]);

                this.recordset.records.push(record);
            }
        }
    }

    generateChildren(parentRecord) {
        const fieldKeys = Object.keys(parentRecord);
        let children = [];
        for (let i = 0; i < fieldKeys.length; i++) {
            if (fieldKeys[i].indexOf(CHILDSUFFIX) > -1) {
                let records = [];
                for (let ii = 0; ii < parentRecord[fieldKeys[i]].length; ii++) {
                    let record = this.setFieldsandValues(parentRecord[fieldKeys[i]][ii]);
                    records.push(record);
                }
                children.push({ objectName: fieldKeys[i].replace(CHILDSUFFIX, "__c"), fields: [], records: records });
            }
        }

        if (children.length <= 0) {
            for (let i = 0; i < this.childObjectNames.length; i++) {
                children.push({ objectName: this.childObjectNames[i], fields: [], records: [] });
            }
        }

        return children;
    }

    setFieldsandValues(record) {
        let returnRecord = {};
        const fieldKeys = Object.keys(record);

        for (let i = 0; i < fieldKeys.length; i++) {
            if (fieldKeys[i].indexOf(CHILDSUFFIX) == -1) {
                returnRecord[fieldKeys[i]] = record[fieldKeys[i]];
            }
        }

        return returnRecord;
    }

    getFields() {
        const helperFunction = new HelperFunctions();
        if (this.layouts && this.recordset.objectName) {
            this.recordset.fields = helperFunction.getLayoutFields(
                this.layouts,
                this.recordset.objectName,
                this.excludeFields
            );
            for (let i = 0; i < this.recordset.records.length; i++) {
                for (let ii = 0; ii < this.recordset.records[i].children.length; ii++) {
                    this.recordset.records[i].children[ii].fields = helperFunction.getLayoutFields(
                        this.layouts,
                        this.recordset.records[i].children[ii].objectName,
                        this.excludeFields
                    );
                }
            }

            this.records = this.recordset;
        }
    }

    addRecord(event) {
        const copyKeys = ["objectName", "fields"];
        let recordset;
        let returnRecordset = { records: [] };

        const fkField = new HelperFunctions().getFKField(
            this.results,
            event.target.parentElement.value,
            event.target.title
        );

        if (this.records.objectName == event.target.title) {
            recordset = this.records;
        } else {
            for (let i = 0; i < this.records.records.length; i++) {
                for (let ii = 0; ii < this.records.records[i].children.length; ii++) {
                    if (this.records.records[i].children[ii].objectName == event.target.title) {
                        recordset = this.records.records[i].children[ii];
                    }
                }
            }
        }

        for (let i = 0; i < copyKeys.length; i++) {
            returnRecordset[copyKeys[i]] = recordset[copyKeys[i]];
        }
        returnRecordset.records.push({ [fkField]: event.target.value });
        this.recordset = returnRecordset;
        this.add = true;
    }

    transactionCompleted(event) {
        this.add = false;
        if (event.detail.close) {
            const transactionComplete = new CustomEvent("transactioncomplete", {
                detail: { refresh: true, success: this.success }
            });
            this.dispatchEvent(transactionComplete);
        }
    }

    handleSectionToggle(event) {
        if (this.activeSection != "") {
            this.activeSection = "A";
        } else {
            this.activeSection = "";
        }
    }
}
