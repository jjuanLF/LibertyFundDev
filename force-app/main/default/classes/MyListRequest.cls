/*********************************************************************************************
Created By: Sam Brandenburg
Email: sam.brandenburg@revelanttech.com
Created: 01/25/2020
Description: Class responsible for building MyList request 
*********************************************************************************************/
public class MyListRequest extends HttpRequestElement{
    
	/** 
    * @description Constructor
    */  
    public MyListRequest(String url, String createRequestJSON, String method) {
        setEndpoint(url);
        setMethod(method);
        setBody(createRequestJSON);
    }
    
    @TestVisible
    public class MyListRequestPayload {
        @TestVisible
        public String user_name;
		@TestVisible
        public String list_name;
        @TestVisible
        public String liberty_id;
		@TestVisible
        public List<String> ack_emails;
		@TestVisible
        public List<Suggestion_data> suggestions;
    }

    @TestVisible
    public class Suggestion_data {
        @TestVisible
        public Integer pid;
        @TestVisible
        public String comments;
        @TestVisible
        public Person_data person_data;
    }
    
    @TestVisible
    public class Aff {
        @TestVisible
		public String organization;
        @TestVisible
		public String title;
        @TestVisible
		public Boolean primary;
	}

    @TestVisible
	public class Addresses {
        @TestVisible
		public String addrType;
        @TestVisible
		public String organization;
        @TestVisible
		public String addr1;
        @TestVisible
		public String addr2;
        @TestVisible
		public String addr3;
        @TestVisible
		public String city;
        @TestVisible
		public String state;
        @TestVisible
		public String zip;
        @TestVisible
		public String country;
        @TestVisible
		public String phone1;
        @TestVisible
		public String phone2;
        @TestVisible
		public String phone3;
        @TestVisible
		public String phone4;
        @TestVisible
		public String phType3;
        @TestVisible
		public String phType4;
        @TestVisible
		public Boolean for_list;
        @TestVisible
		public Boolean for_correspondence;
	}

    @TestVisible
	public class Person_data {
        @TestVisible
        public String sf_id;
        @TestVisible
		public String prefix;
        @TestVisible
		public String first;
        @TestVisible
		public String middle;
        @TestVisible
		public String last;
        @TestVisible
		public String suffix;
        @TestVisible
		public List<Aff> aff;
        @TestVisible
		public String url;
        @TestVisible
		public List<Emails> emails;
        @TestVisible
		public List<Addresses> addresses;
	}

    @TestVisible
	public class Emails {
        @TestVisible
		public String address;
        @TestVisible
		public Boolean for_list;
        @TestVisible
		public Boolean for_correspondence;
	}
}