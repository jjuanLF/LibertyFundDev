public with sharing class ContactStagingController {
	@AuraEnabled(cacheable=true)
	public static List<sObject> getPossibleDuplicates(Id id) {
		try {
			return ContactStagingPossibleDuplicate.getPossibleContactDuplicates(id);
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
	@AuraEnabled
	public static Boolean setContactToMerge(Id id, Id contactId, List<String> fieldsToMergeList) {
		try {
			return ContactStagingMergeContact.setContactToMerge(id, contactId, fieldsToMergeList);
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
	@AuraEnabled
	public static Map<String, List<String>> convertContact() {
		try {
			return ContactStagingConversion.convertContact();
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
}
