import { LightningElement, api, track, wire } from "lwc";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { getRecordUi, updateRecord } from "lightning/uiRecordApi";
import { NavigationMixin } from "lightning/navigation";
import getPossibleDuplicates from "@salesforce/apex/ContactStagingController.getPossibleDuplicates";
import CONTACT from "@salesforce/schema/Contact";
import HelperFunctions from "./helperFunctions";

export default class PossibleDuplicate extends NavigationMixin(LightningElement) {
    @api recordId;
    @track openModal;
    @track records;
    contactId;
    objectInfo;
    options;
    recordUI;
    values;

    helperFunctions = new HelperFunctions();
    contactRecordPageReference = {
        type: "standard__recordPage",
        attributes: {
            recordId: "placeholder",
            objectApiName: "Contact",
            actionName: "view"
        }
    };

    @wire(getObjectInfo, { objectApiName: CONTACT })
    objectInfo;

    @wire(getRecordUi, { recordIds: "$recordId", layoutTypes: "Full", modes: "View" })
    recordUI;

    async connectedCallback() {
        await this.initialize();
    }

    async initialize() {
        let data = await getPossibleDuplicates({ id: this.recordId });

        if (data) {
            const fieldMap = this.helperFunctions.createFieldMap(this.objectInfo.data.fields);
            let record = [];
            const dataKeys = Object.keys(data[0]);

            for (let i = 0; i < data.length; i++) {
                let fieldData = [];
                for (let ii = 0; ii < dataKeys.length; ii++) {
                    if (!this.helperFunctions.filterFields(dataKeys[ii]) && dataKeys[ii] != "Name") {
                        if (fieldMap.get(dataKeys[ii]) != undefined) {
                            fieldData.push({ Id: ii, field: fieldMap.get(dataKeys[ii]), value: data[i][dataKeys[ii]] });
                        }
                    }
                }
                record.push({
                    Id: data[i].Id,
                    Name: data[i].Name,
                    FieldValues: fieldData
                });
            }
            this.records = record;
        }
    }

    mergeContact(event) {
        if (!this.openModal) {
            this.contactId = event.target.value;
            this.options = this.helperFunctions.createPickListOptions(this.recordUI);
            this.values = this.helperFunctions.getSelectedMergeFields(
                this.recordUI.data.records[this.recordId],
                this.options
            );
            this.openModal = true;
        }
    }

    navigateToRecord(event) {
        this.contactRecordPageReference.attributes.recordId = event.target.title;
        this[NavigationMixin.GenerateUrl](this.contactRecordPageReference).then((url) => {
            window.open(url, "_blank");
            event.preventDefault();
            event.stopPropagation();
        });
    }

    handleModal(event) {
        if (!event.detail.openModal) {
            this.openModal = false;
            if (event.detail.success) {
                this.updateRecordView(this.recordId);
            }
        }
    }

    updateRecordView(recordId) {
        updateRecord({ fields: { Id: recordId } });
    }
}
