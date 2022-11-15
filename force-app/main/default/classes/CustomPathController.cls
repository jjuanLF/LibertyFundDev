public with sharing class CustomPathController {
    @AuraEnabled
    public static Map<Object, List<String>> getDependentPicklistValues(String sObjectName, String fieldName) {
        try {
            return DependentListHelper.getDependentPicklistValues(sObjectName, fieldName);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
