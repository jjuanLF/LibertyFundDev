declare module "@salesforce/apex/ContactStagingController.getPossibleDuplicates" {
  export default function getPossibleDuplicates(param: {id: any}): Promise<any>;
}
declare module "@salesforce/apex/ContactStagingController.setContactToMerge" {
  export default function setContactToMerge(param: {id: any, contactId: any, fieldsToMergeList: any}): Promise<any>;
}
declare module "@salesforce/apex/ContactStagingController.convertContact" {
  export default function convertContact(): Promise<any>;
}
