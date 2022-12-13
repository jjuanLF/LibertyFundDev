export default class HelperFunctions {
    getLayoutFields(layouts, objectName, excludeFields) {
        let fields = [];
        for (let i = 0; i < layouts.length; i++) {
            if (layouts[i].fullName.includes(objectName)) {
                for (let ii = 0; ii < layouts[i].layoutSections.length; ii++) {
                    for (let iii = 0; iii < layouts[i].layoutSections[ii].layoutColumns.length; iii++) {
                        if (layouts[i].layoutSections[ii].layoutColumns[iii].layoutItems) {
                            for (
                                let iv = 0;
                                iv < layouts[i].layoutSections[ii].layoutColumns[iii].layoutItems.length;
                                iv++
                            ) {
                                if (
                                    !excludeFields.includes(
                                        layouts[i].layoutSections[ii].layoutColumns[iii].layoutItems[iv].field
                                    )
                                ) {
                                    fields.push(layouts[i].layoutSections[ii].layoutColumns[iii].layoutItems[iv].field);
                                }
                            }
                        }
                    }
                }
            }
        }
        return fields;
    }

    getObjectInfoLabels(results, objectApiNames) {
        let labels = {};

        for (let i = 0; i < objectApiNames.length; i++) {
            for (let ii = 0; ii < results.length; ii++) {
                let property = "child";
                if (results[i].result.apiName == objectApiNames[i]) {
                    switch (i) {
                        case 0:
                            property = "grandparent";
                            break;
                        case 1:
                            property = "parent";
                            break;
                        default:
                            labels[property + "Table"] = objectApiNames[i];
                            break;
                    }
                }

                labels[property] = results[i].result.label;
                labels[property + "Button"] = "Add " + labels[property];
            }
        }

        return labels;
    }

    getFKField(results, parent, child) {
        for (let i = 0; results.length; i++) {
            if (results[i].result.apiName == parent) {
                for (let ii = 0; ii < results[i].result.childRelationships.length; ii++) {
                    if (results[i].result.childRelationships[ii].childObjectApiName == child) {
                        return results[i].result.childRelationships[ii].fieldName;
                    }
                }
            }
        }

        return null;
    }
}
