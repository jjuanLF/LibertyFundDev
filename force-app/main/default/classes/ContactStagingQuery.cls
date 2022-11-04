public with sharing class ContactStagingQuery {
	public static ContactStagingTable__c getContactStagingTableById(Id id) {
		return [
			SELECT
				First_Name__c,
				Last_Name__c,
				FullName__c,
				Affiliation_Name__c,
				Public_Email__c,
				Correspondence_Email__c,
				Email01__c
			FROM ContactStagingTable__c
			WHERE Id = :id
		];
	}

	public static List<ContactStagingTable__c> getContactStagingTable() {
		return [
			SELECT
				First_Name__c,
				Last_Name__c,
				FullName__c,
				Middle__c,
				Affiliation_Name__c,
				Public_Email__c,
				Correspondence_Email__c,
				Email01__c,
				Phone__c,
				Mobile__c,
				MergeFields__c,
				MergeContactId__c,
				Salutation__c,
				ProgramId__c
			FROM ContactStagingTable__c
		];
	}
}
