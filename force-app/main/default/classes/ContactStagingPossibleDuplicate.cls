public without sharing class ContactStagingPossibleDuplicate {
	public static List<SObject> getPossibleContactDuplicates(Id id) {
		Set<Id> idSet = new Set<Id>();
		try {
			List<Datacloud.FindDuplicatesResult> duplicateResultsList = Datacloud.FindDuplicates.findDuplicates(
				new List<ContactStagingTable__c>{ new ContactStagingTable__c(Id = id) }
			);

			for (Datacloud.FindDuplicatesResult findDuplicateResult : duplicateResultsList) {
				for (Datacloud.DuplicateResult duplicateResult : findDuplicateResult.duplicateresults) {
					for (Datacloud.MatchResult matchResult : duplicateResult.matchresults) {
						for (Datacloud.MatchRecord matchRecord : matchResult.matchrecords) {
							idSet.add(matchRecord.record.Id);
						}
					}
				}
			}
			if (idSet.size() > 0) {
				return getContactDetails(idSet);
			}
			return null;
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	private static List<SObject> getContactDetails(Set<Id> idSet) {
		return ContactQueries.getContactsByIds(idSet);
	}
}
