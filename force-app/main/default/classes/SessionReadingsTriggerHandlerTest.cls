@isTest
public class SessionReadingsTriggerHandlerTest {

    @isTest
    private static void testPageCountCalculation() {
 
        Campaign oCampaign = new Campaign();
        oCampaign.Name = 'Test Campaign';
        insert oCampaign;
        
        Session__c oSession = new Session__c();
        oSession.Program__c = oCampaign.id;
        oSession.Name = 'Test Session';
        insert oSession;
        
        Session_Readings__c oSessRdgs = new Session_Readings__c();
        oSessRdgs.Session__c = oSession.id;
        oSessRdgs.Pages__c = '1-2, 2-3, 5, 8-10';
        insert oSessRdgs;
        
        // perform update for code coverage
        oSessRdgs.Pages__c = '1';
        update oSessRdgs;
    }
}