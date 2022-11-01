export default class HelperFunctions {
	createFieldMap(fields) {
		const fieldMap = new Map();
		const fieldKeys = Object.keys(fields);

		for (let i = 0; i < fieldKeys.length; i++) {
			fieldMap.set(fieldKeys[i], fields[fieldKeys[i]].label);
		}

		return fieldMap;
	}

	createPickListOptions(recordUI, selected) {
		let options = [];
		const objectIdKeys = Object.keys(recordUI.data.layouts);

		for (let i = 0; i < objectIdKeys.length; i++) {
			const tableIdKeys = Object.keys(recordUI.data.layouts[objectIdKeys[i]]);
			for (let ii = 0; ii < tableIdKeys.length; ii++) {
				let sections = recordUI.data.layouts[objectIdKeys[i]][tableIdKeys[ii]].Full.View.sections;
				for (let iii = 0; iii < sections.length; iii++) {
					let layoutRows = sections[iii].layoutRows;
					for (let iv = 0; iv < layoutRows.length; iv++) {
						let layoutItems = layoutRows[iv].layoutItems;
						for (let v = 0; v < layoutItems.length; v++) {
							let layoutComponents = layoutItems[v].layoutComponents;
							for (let vi = 0; vi < layoutComponents.length; vi++) {
								if (
									layoutComponents[vi].apiName &&
									this.isPopulated(recordUI, layoutComponents[vi].apiName) &&
									layoutComponents[vi].apiName.includes("__c") &&
									!this.filterFields(layoutComponents[vi].apiName)
								) {
									options.push({
										label: layoutComponents[vi].label,
										value: layoutComponents[vi].apiName,
									});
								}
							}
						}
					}
				}
			}
		}
		return options;
	}

	isPopulated(recordUI, field) {
		const recordKeys = Object.keys(recordUI.data.records);

		for (let i = 0; i < recordKeys.length; i++) {
			if (recordUI.data.records[recordKeys[i]].fields[field].value) {
				return true;
			}
		}
		return false;
	}

	filterFields(field) {
		const filteredValues = ["Id", "Error", "Merge"];

		for (let i = 0; i < filteredValues.length; i++) {
			if (field.includes(filteredValues[i])) {
				return true;
			}
		}

		return false;
	}

	getSelectedMergeFields(recordUI, options) {
		let mergeFields = recordUI.fields.MergeFields__c.value?.split(";");
		let values = [];

		if (mergeFields) {
			for (let i = 0; i < mergeFields.length; i++) {
				for (let ii = 0; ii < options.length; ii++) {
					if (options[ii].value == mergeFields[i]) {
						values.push(options[ii].value);
					}
				}
			}
		}

		return values;
	}
}
