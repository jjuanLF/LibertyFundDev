public without sharing class ContactQueries {
	public static List<Contact> getContactsByIds(Set<Id> idSet) {
		return [
			SELECT Id, Name, Public_Email__c, Correspondence_Email__c, Email, Phone, MobilePhone, Account.Name
			FROM Contact
			WHERE Id IN :idSet
		];
	}
}
