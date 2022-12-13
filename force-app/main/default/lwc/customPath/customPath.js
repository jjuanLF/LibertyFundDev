//From: https://github.com/jamessimone/apex-mocks-stress-test/blob/lwc-path/sfdx/main/default/lwc/customPath/customPath.html
import { api, LightningElement, track, wire } from "lwc";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { getRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getDependentPicklistValues from "@salesforce/apex/CustomPathController.getDependentPicklistValues";
import updateSubStage from "@salesforce/apex/CustomPathController.updateSubStage";
import getUserInfo from "@salesforce/apex/DisplayController.getUserInfo";
import Constants from "./constants";

export default class CustomPath extends LightningElement {
    @api recordId;
    @api objectApiName;
    @api childField;
    @api parentField;
    @track fields;
    @wire(getObjectInfo, { objectApiName: "$objectApiName" })
    objectInfo;
    userInfo;
    constants = new Constants();

    @track advanceButtonText = this.constants.MARK_COMPLETED;
    @track showAdvanceButton = false;
    @track value;
    @track currentValue;
    @track valueList = [];

    pickListMap;
    parentValue;
    currentParentValue;
    currentIndex;
    _hasRendered = false;
    _value;

    @wire(getRecord, {
        recordId: "$recordId",
        fields: "$fields"
    })
    record({ data, error }) {
        const recordCallBack = (data) => {
            if (this.parentValue != data.fields[this.parentField].displayValue) {
                if (this.valueList.length > 0) {
                    this.valueList.length = 0;
                }
                this.getDependentPickList(this.objectApiName, this.childField);
            }
            this.value = this._getValueOrDefault(data, this.childField);
            this.parentValue = this._getValueOrDefault(data, this.parentField);
            this.currentValue = this.value;
            this.currentParentValue = this.parentValue;
        };

        this._handleWireCallback({ data, error, cb: recordCallBack });
    }

    @wire(getUserInfo)
    userInfo;

    connectedCallback() {
        if (this.recordId) {
            this.fields = [this.objectApiName + "." + this.parentField, this.objectApiName + "." + this.childField];
        }
    }

    renderedCallback() {
        if (!this._hasRendered && this.hasData) {
            //prevents the advance button from jumping to the side
            //as the rest of the component loads
            if (this.hasAccess()) {
                this.showAdvanceButton = true;
            }
            this._hasRendered = true;
        }
        if (this.hasData) {
            const current = this.valueList.find((value) => this.currentValue.includes(value.label)) || {
                label: "Unknown"
            };
            current.ariaSelected = true;
            current.class = "slds-path__item slds-is-current slds-is-active";

            const currentIndex = this.valueList.indexOf(current);
            this.valueList.forEach((value, index) => {
                if (index > currentIndex) {
                    value.class = value.class
                        .replace("slds-is-current", "")
                        .replace("slds-is-active", "slds-is-incomplete");
                }
            });
        }
    }

    //private methods and getters
    get pathActionIconName() {
        return this.advanceButtonText === this.constants.MARK_COMPLETED ? "utility:check" : "";
    }

    get hasData() {
        return !!(this.currentValue && this.valueList.length > 0);
    }

    modalSaveHandler = async (event) => {
        event.stopPropagation();
        event.preventDefault();

        const allValid = [...this.template.querySelectorAll(".slds-form-element")].reduce((validSoFar, formElement) => {
            formElement.reportValidity();
            return validSoFar && formElement.checkValidity();
        }, true);
        if (allValid) {
            await this._saveProgramAndToast();
        }
    };

    handleValueClick(event) {
        event.stopPropagation();
        const selectedIndex = event.currentTarget.value;
        const currentIndex = this.valueList.findIndex((value) => value.label === this.value);
        if (!this.hasAccess && selectedIndex - currentIndex > 1) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Warning!",
                    variant: "error",
                    message: "You are prohibited from moving beyond the next stage"
                })
            );
            return;
        }
        const updatedValue = event.target.textContent;
        this.advanceButtonText = updatedValue === this.value ? this.constants.MARK_COMPLETED : "Mark As Current Stage";
        this.currentValue = updatedValue;

        if (this.value !== this.currentValue) {
            this._updateValue();
        }
    }

    async handleAdvanceButtonClick(event) {
        event.stopPropagation();

        if (this.value === this.currentValue) {
            const nextValueIndex = this.valueList.findIndex((value) => value.label === this.value) + 1;
            this.currentValue = this.valueList[nextValueIndex].label;
            await this._saveProgramAndToast();
        } else {
            await this._saveProgramAndToast();
        }
    }

    async getDependentPickList(sObjectName, fieldName) {
        this.pickListMap = await getDependentPicklistValues({ sObjectName: sObjectName, fieldName: fieldName });

        if (this.pickListMap) {
            this.currentIndex = this.getIndexOfValue(this.currentValue, this.pickListMap[this.parentValue]);
            for (let i = 0; i < this.pickListMap[this.parentValue].length; i++) {
                this.valueList.push(this._getPathItem(this.pickListMap[this.parentValue][i]));
            }
        }
    }

    _handleWireCallback = ({ data, error, cb }) => {
        if (error) console.error(error);
        else if (data) {
            cb(data);
        }
    };

    _getPathItem(value) {
        const ariaSelected = !!this.currentValue ? this.currentValue.includes(value) : false;
        const isCurrent = !!this.value ? this.value.includes(value) : false;
        let index = this.getIndexOfValue(value);

        const classList = ["slds-path__item"];
        if (ariaSelected) {
            classList.push("slds-is-active");
        } else {
            if ((index > 0 && index > this.currentIndex) || this.currentValue == this.constants.ABANDONED) {
                classList.push("slds-is-incomplete");
            } else if (index < this.currentIndex) {
                classList.push("slds-is-complete");
            }
        }
        if (isCurrent) {
            classList.push("slds-is-current");
        }
        return {
            ariaSelected: false,
            class: classList.join(" "),
            label: value
        };
    }

    _getValueOrDefault(data, val) {
        return data ? data.fields[val].displayValue : "";
    }

    getIndexOfValue(value) {
        for (let i = 0; i < this.pickListMap[this.parentValue].length; i++) {
            if (value == this.pickListMap[this.parentValue][i]) {
                return i;
            }
        }
    }

    async _saveProgramAndToast() {
        let error;
        try {
            this.value = this.currentValue;
            await updateSubStage({ id: this.recordId, value: this.value });
            this.currentIndex = this.getIndexOfValue(this.currentValue);
            this._updateValue();
            this.advanceButtonText = this.constants.MARK_COMPLETED;
            this.showAdvanceButton = this.hasAccess();
        } catch (err) {
            error = err;
            console.error(err);
        }
        this.dispatchEvent(
            new ShowToastEvent({
                title: !error ? "Success!" : "Record failed to save",
                variant: !error ? "success" : "error",
                message: !error
                    ? "Record successfully updated!"
                    : `Record failed to save with message: ${JSON.stringify(error)}`
            })
        );
    }

    _updateValue() {
        //update the shown subStages based on the selection
        const newValueList = [];
        for (let index = 0; index < this.valueList.length; index++) {
            const value = this.valueList[index];
            const pathItem = this._getPathItem(value.label);
            /*if (this.value !== this.recordValue || pathItem.label !== this.value) {
                pathItem.class = pathItem.class.replace("slds-is-complete", "").replace("  ", " ");
            }*/
            newValueList.push(pathItem);
        }
        this.valueList = newValueList;
    }

    hasAccess() {
        if (
            this.userInfo.data.Profile.Name == this.constants.LFADMINPROFILE ||
            this.userInfo.data.Profile.Name == this.constants.SYSTEMADMINISTRATORPROFILE ||
            (this.userInfo.data.Profile.Name == this.constants.LFREPPROFILE &&
                this.currentValue.toUpperCase().includes("REP"))
        ) {
            return true;
        }

        return false;
    }
}
