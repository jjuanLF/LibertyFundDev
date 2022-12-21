public without sharing class CustomPathController {
    @AuraEnabled
    public static Map<Object, List<String>> getDependentPicklistValues(String sObjectName, String fieldName) {
        try {
            return DependentListHelper.getDependentPicklistValues(sObjectName, fieldName);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string updateSubStage(Id id, String value) {
        try {
            update new Program__c(Id = id, SubStage__c = value);
            return 'Success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
