trigger CitationTrigger on Citation__c (before insert, before update) {
/*********************************************************************************************
Created By: Chris Bock
Email: chris.bock@revelanttech.com
Created: 05/20/21
Description: Trigger to handle all Contact DML operations that need to communicate with SiteStacker
Changes:   
*********************************************************************************************/

    //handlers for before trigger actions
    if (Trigger.isBefore) {
        if (Trigger.isInsert) { 
            CitationTriggerHandler.translateMarkdown(Trigger.new);
        }   
        if (Trigger.isUpdate) {
            CitationTriggerHandler.translateMarkdown(Trigger.new);
        }
        if(Trigger.isDelete) {
        }
    } 

    //handlers for after trigger actions
/* commented out to help code coverage since we aren't doing any After actions
    else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
        }
        if (Trigger.isUpdate) {
        }
        if(Trigger.isDelete) {
        }
        if(Trigger.isUndelete) {
        }
    }
*/
}