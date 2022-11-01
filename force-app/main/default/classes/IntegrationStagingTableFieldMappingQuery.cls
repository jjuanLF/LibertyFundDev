public without sharing class IntegrationStagingTableFieldMappingQuery {
	public static Map<String, Integration_Staging_Table_Field_Mapping__mdt> IntegrationStagingTableFieldMappingByObject(
		String sourceObjectName
	) {
		Map<String, Integration_Staging_Table_Field_Mapping__mdt> fieldMappingMap = new Map<String, Integration_Staging_Table_Field_Mapping__mdt>();

		List<Integration_Staging_Table_Field_Mapping__mdt> integrationStagingTableFieldMappingList = [
			SELECT
				Id,
				Source_Object__c,
				Source_Field__c,
				Target_Object__c,
				Target_Field__c,
				Query_Object__c,
				Query_Field__c,
				Truncation_Limit__c
			FROM Integration_Staging_Table_Field_Mapping__mdt
			WHERE Source_Object__c = :sourceObjectName
		];

		for (
			Integration_Staging_Table_Field_Mapping__mdt integrationStagingTableFieldMapping : integrationStagingTableFieldMappingList
		) {
			fieldMappingMap.put(
				integrationStagingTableFieldMapping.Source_Field__c,
				integrationStagingTableFieldMapping
			);
		}

        return fieldMappingMap;
	}
}
