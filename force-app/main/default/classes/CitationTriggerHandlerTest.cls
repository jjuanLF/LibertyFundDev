@isTest
private class CitationTriggerHandlerTest {

    @isTest
    private static void testCitationMarkdown() {
        Citation__c oCit = new Citation__c();
        
        oCit.Citation_Markdown__c = 'This *is* a test\\n of \\markup';
        insert oCit;
        
        oCit.Citation_Markdown__c = 'This is an update pass for better code coverage';
        update oCit;
    }
}