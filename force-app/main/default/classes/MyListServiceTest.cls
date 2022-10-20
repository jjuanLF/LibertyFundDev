/*****************************************
* Revelant Technologies
* Chris.Bock@revelanttech.com
* 
* This is the test class for MyListService
*****************************************/
@IsTest public class MyListServiceTest {
    
    @IsTest public static void testSendSuggestionList() {
        
        // define the objects we need to create for test data
        Contact oContact = new Contact(Firstname='Test',Lastname='Contact', MailingStreet='123 Main', MailingCity='Anywhere', MailingState='IN', MailingPostalCode='99999');
        insert oContact;

        Account oAffilAcct = new Account(Name='Affil Account');
        insert oAffilAcct;
        
        /*npe5__Affiliation__c oAffil = new npe5__Affiliation__c(npe5__Contact__c=oContact.Id, npe5__Organization__c=oAffilAcct.Id);
        insert oAffil;*/
        
        Email_Address__c oEmail = new Email_Address__c(Email__c='Test@gmail.com',Correspondence_Email__c=true,Public_Email__c=true,Contact__c=oContact.Id);
        insert oEmail;
        
        Lead oLead = new Lead(Firstname='Test',Lastname='Lead',Company='TestCo');
        insert oLead;
        
        Campaign oProgram = new Campaign(Name='Test Program', E_number__c='E00-0000');
        insert oProgram;
        
        MyList__c oMyList = new MyList__c(Name='Test List',Campaign__c=oProgram.Id);
        insert oMyList;
        
        MyList_Conferee__c oMyListConfContact = new MyList_Conferee__c(MyList__c=oMyList.id, Contact__c=oContact.Id);
        insert oMyListConfContact;
        
        MyList_Conferee__c oMyListConfLead = new MyList_Conferee__c(MyList__c=oMyList.id, Lead__c=oLead.Id);
        insert oMyListConfLead;
        
        // set up input parameters to mimic how Flow passes params
        List<String> lFlowParam = new List<String>();
        lFlowParam.add(oMyList.id);
        
        Test.startTest();
        
        //MyListService.coverageMethod();
        
        MockCallouts mock = new MockCallouts();
        String response = '{"status": "ok", "transaction_id": "016128876496994276764V0s"}';
        mock.add('https://us-central1-lf-domain-project.cloudfunctions.net/lfsf/op/conf_suggestion', response, 200, 'OK');
        Test.setMock(HTTPCalloutMock.class, mock.getMockCallout());
        
        // normal case, suggestion list with suggested conferee
        MyListService.invoke(lFlowParam);
        
        Test.stopTest();
    }    
}