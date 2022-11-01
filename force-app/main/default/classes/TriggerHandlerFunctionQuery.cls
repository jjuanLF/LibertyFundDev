public without sharing class TriggerHandlerFunctionQuery {
	public static List<TriggerHandlerFunction__mdt> getTriggerHandlerFunctionsByObject(String objectName) {
		return [
			SELECT ApexClass__c
			FROM TriggerHandlerFunction__mdt
			WHERE Table__c = :objectName AND Active__c = TRUE
			ORDER BY RunSequence__c
		];
	}
}
