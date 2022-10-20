@isTest
public class TestDataFactory {
	
    //Create a test Sync History (batch)
    public static Sync_History__c getBatch(){
        Sync_History__c batch = new Sync_History__c(Batch_Number__c = 'LF20YYMMDD-095902FY', Status__c = 'Uploaded');
        insert batch;
        return batch;
    }
    
    //Create a test Household account
    public static Account getHouseholdAccount(){
        Account acc = new Account(Name = 'McTesterson Household', RecordTypeId = '0124S0000009bv2QAA'); //Household Account
        insert acc;
        return acc;
    }

    //Create a test Organization account (Affiliation)
    public static Account getOrganizationAccount(){
        Account acc = new Account(Name = 'University of Testerville', RecordTypeId = '0124S0000009bv3QAA'); //Organization Account
        insert acc;
        return acc;
    }

    //Create a test Vendor account (Hotel)
    public static Account getVendorAccount(){
        Account acc = new Account(Name = 'Hotel de Testerville', RecordTypeId = '0124S0000004UzIQAU'); //Vendor Account
        acc.Billing_Contact__c = 'Testopher Testerington';
        acc.Billing_Contact_Email__c = 'testopher@test.com';
        acc.LF_Vendor_ID__c = '1010772';
        acc.ShippingStreet = '123 Testing Lane';
        acc.ShippingCity = 'Testerville';
        acc.ShippingState = 'IN';
        acc.ShippingPostalCode = '46391';
        acc.ShippingCountry = 'US';
        insert acc;
        return acc;
    }

    //Create a test Conferee contact
    public static Contact getConfereeContact(){
        Account household = TestDataFactory.getHouseholdAccount();
        Account affiliation = TestDataFactory.getOrganizationAccount();
        Contact con = new Contact();
        con.RecordTypeId = '0124S0000004UzMQAU'; //Conferee
        //con.AccountId = household.Id;
        con.AccountId = affiliation.Id;
        con.FirstName = 'Testerina';
        con.LastName = 'McTesterson';
        con.Title = 'Professor of Awesome Studies';
        con.Person_Type__c = 'Academic';
        con.Correspondence_Email__c = 'testerina@test.com';
        con.Public_Email__c = 'testerina@test.com';
        con.Intacct_Vendor_ID__c = '851830';
        con.LFPID__c = '1914';
        insert con;
        return con;
    }
    
    //Create a list of test Conferee contacts
    public static List<Contact> getListConfereeContacts(Integer numToCreate){
        Account household = TestDataFactory.getHouseholdAccount();
        Account affiliation = TestDataFactory.getOrganizationAccount();
        List<Contact> listConToInsert = new List<Contact>();
        for(Integer i = 0; i < numToCreate; i++){
            Contact con = new Contact();
            con.RecordTypeId = '0124S0000004UzMQAU'; //Conferee
            //con.AccountId = household.Id;
        	con.AccountId = affiliation.Id;
            con.FirstName = 'Test' + i;
            con.LastName = 'Tester' + i;
            con.Title = 'Professor of Awesome Studies';
            con.Person_Type__c = 'Academic';
            con.Correspondence_Email__c = 'test' + i + '@test' + i + '.com';
        	con.Public_Email__c = 'test' + i + '@test' + i + '.com';
            con.LFPID__c = String.valueOf(i);
            listConToInsert.add(con);
        }
        insert listConToInsert;
        return listConToInsert;
    }

    //Create a test Fellow contact
    public static Contact getFellowContact(){
        Account household = TestDataFactory.getHouseholdAccount();
        Contact con = new Contact();
        con.RecordTypeId = '0124S0000004UzNQAU'; //Employee
        con.AccountId = household.Id;
        con.FirstName = 'Testerella';
        con.LastName = 'Testerez';
        con.Title = 'Senior Fellow';
        con.Person_Type__c = 'LF Rep';
        con.Active_Fellow__c = TRUE;
        con.Correspondence_Email__c = 'testerella@test.com';
        con.Public_Email__c = 'testerella@test.com';
        con.LFPID__c = '69382';
        con.Fellow_Code__c = 'TTT';
        insert con;
        return con;
    }

    //Create a test Core Conference program (campaign)
    public static Campaign getCoreConference(Boolean inclFellow){
        Account hotel = TestDataFactory.getVendorAccount();
        Campaign prog = new Campaign();
        prog.Name = 'E20-6811';
        prog.E_number__c = 'E20-6811';
        prog.LFBudgId__c = '5995';
        prog.EndDate = Date.newInstance(2021,1,2);
        prog.StartDate = Date.newInstance(2021,1,1);
        if(inclFellow){
            Contact fellow = TestDataFactory.getFellowContact();
            prog.Fellow__c = fellow.Id;
        	prog.Submitting_Fellow__c = fellow.Id;
        }
        prog.Hotel__c = hotel.Id;
        prog.Long_Name__c = 'Modern Monetary Theory and Populism';
        prog.Short_Name__c = 'Modern Monetary Theory';
        prog.RecordTypeId = '0124S0000004UzKQAU'; //[Core] Conference
        prog.Status = 'Approved';
        insert prog;
        return prog;
    }
    
    //Create a list of test Core Conference program (campaign)
    public static List<Campaign> getListCoreConferences(Integer numToCreate){
        List<Campaign> listProgToInsert = new List<Campaign>();
        for(Integer i = 0; i < numToCreate; i++){
            Campaign prog = new Campaign();
            prog.Name = 'E20-' + i;
            prog.E_number__c = 'E20-' + i;
            prog.LFBudgId__c = String.valueOf(i);
            prog.EndDate = Date.newInstance(2021,1,2);
            prog.StartDate = Date.newInstance(2021,1,1);
            prog.Long_Name__c = 'Test Campaign ' + i;
            prog.Short_Name__c = 'Test Campaign ' + i;
            prog.RecordTypeId = '0124S0000004UzKQAU'; //[Core] Conference
            prog.Status = 'Approved';
            listProgToInsert.add(prog);
        }
        insert listProgToInsert;
        return listProgToInsert;
    }

    //Create a test Citation
    public static Citation__c getCitation(){
        Citation__c cit = new Citation__c();
        cit.Author__c = 'LaFollette, Hugh';
        cit.BiblioId__c = 'CN00004245';
        cit.Citation__c = 'LaFollette, Hugh. “&quot;Licensing Parents&quot;.” <i>Philosophy and Public Affairs</i> 9, no. 2 (Winter 1980): 182-197.';
        cit.Citation_Markdown__c = 'LaFollette, Hugh. “"Licensing Parents".” <i>Philosophy and Public Affairs</i> 9, no. 2 (Winter 1980): 182-197.';
        cit.Citation_trunc__c = 'LaFollette, Hugh. “&quot;Licensing Parents&quot;.” <i>Philosophy and Public Affairs</i> 9, no. 2 (Winter 1980): 182-197.';
        cit.LF_Book__c = FALSE;
        cit.Name = 'Licensing Parents';
        cit.Publication_Title__c = 'Licensing Parents';
        cit.Publication_Type__c = 'Periodical';
        insert cit;
        return cit;
    }
        
    //Create a test Organization account
    public static Account getAccount(String name, Boolean doInsert){
        Account a = new Account(name = name);
        if(doInsert){
            insert a;
        }
        return a;
    }

    //Create a test user
    public static User generateUser(String profileName){
        UserRole userRole = new UserRole(DeveloperName = 'TestingTeam', Name = 'Testing Team');
        insert userRole;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id,
            LastName = 'last',
            Email = 'Cpt.Awesome@awesomesauce.com',
            Username = 'Cpt.Awesome@awesomesauce.com',
            CompanyName = 'Testing Co',
            Title = 'Captian',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = userRole.Id
        );
        insert u;
        return u;
    }
}