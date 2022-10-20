/*********************************************************************************************
Created By: Casey Boyd
Email: casey.boyd@revelanttech.com
Created: 12/05/2016
Description: This contains the exception tree for the Web Service framework
Changes: 
*********************************************************************************************/
public virtual class WebServiceManagerException extends Exception {
    public virtual class InvalidParameterException extends WebServiceManagerException {} 
    public virtual class NullPointerException extends WebServiceManagerException {} 
    public virtual class CallOutException extends WebServiceManagerException {}  
}