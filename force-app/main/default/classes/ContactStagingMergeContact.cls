public without sharing class ContactStagingMergeContact {
	public static Boolean setContactToMerge(Id id, Id contactId, List<String> fieldsToMergeList) {
		try {
			update new ContactStagingTable__c(
				Id = id,
				MergeContactId__c = contactId,
				MergeFields__c = String.join(fieldsToMergeList, ';')
			);
			return true;
		} catch (DmlException exeception) {
			return false;
		}
	}
}
