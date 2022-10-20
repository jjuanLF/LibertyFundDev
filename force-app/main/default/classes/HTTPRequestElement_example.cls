/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com 
Created: 12/05/2016
Description: This class is a example implementation of the HTTPRequestElement abstract class. A class
             similar to this one will need to be created for each unique endpoint called. 
             
             Follow the installation instuctions below to run this example class.
             
             1. Create a Remote Site Setting
                
                Remote Site Name: HTTPRequestElementExample
                Remote Site URL: https://jsonplaceholder.typicode.com/
                
Changes: 
*********************************************************************************************/  
public with sharing class HTTPRequestElement_example extends HTTPRequestElement  { 
    
    public HTTPRequestElement_example() {
        setEndPoint('https://jsonplaceholder.typicode.com/posts/1'); 
        setMethod('GET');
        setHeader('Content-Type','application/json');  
        setHeader('Accept','application/json');
    }      
}