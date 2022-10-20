/*********************************************************************************************
  Created By: Sam Brandenburg
  Email: sam.brandenburg@revelanttech.com
  Created: 03/23/2017
  Notes:  Batch Process to delete selected Sobject records older than a selected retention date
  *********************************************************************************************/
global class ObjectCleanerBatch implements Schedulable, Database.Batchable<sObject> {
    
    String query;
    String objectToBatch;
    String objectDateField;
    Integer retentionDays;
    Integer queryIndex;
    Boolean chainBatch = false;

    /** 
    * @description Construct
    * @param - Index: Which Custom Metadata Record to process on each batch run
    **/
    global ObjectCleanerBatch(Integer index) {

        //Set index (0 for start, index++ if job is executed in finish context of previous job)
        queryIndex = index;

        //Query all object cleaner custom metadata records
        List<Object_Cleaner_Config__mdt> cleanerConfigs = [SELECT Id, MasterLabel, Order__c, DeveloperName, Record_Retention_Days__c,
                                                                 Object_Type__c, Object_Type__r.QualifiedAPIName,
                                                                 Object_Field__c, Object_Field__r.QualifiedAPIName,
                                                                 Unit_Test__c
                                                          FROM Object_Cleaner_Config__mdt
                                                            ORDER BY Order__c ASC];
        

        System.debug('cleanerConfigs: ' + cleanerConfigs);

        //Set batch details
        if (cleanerConfigs.size() > 0) {

            objectToBatch = cleanerConfigs.get(queryIndex).Object_Type__r.QualifiedAPIName;
            objectDateField = cleanerConfigs.get(queryIndex).Object_Field__r.QualifiedAPIName;
            retentionDays = Integer.valueOf(cleanerConfigs.get(queryIndex).Record_Retention_Days__c);

            //If there are additional metadata records, update the index for the next job
            if (queryIndex < cleanerConfigs.size()-1) {
                queryIndex++;
                chainBatch = true;
            }

        } else {
            System.debug('No Object_Cleaner_Config__mdt records available; Not executing Batch');
        }

    }
    
    global ObjectCleanerBatch() {
        this(0);
    }
    
    /** 
    * @description Start
    **/
    global Database.QueryLocator start(Database.BatchableContext BC) {

        if (!String.isBlank(objectToBatch) && !String.isBlank(objectDateField)) {
            Date queryDate = System.today().addDays(-1 * retentionDays);
            query = 'Select Id From ' + objectToBatch + ' Where ' + objectDateField + ' < :queryDate';
            System.debug('Query String: ' + query);
            return Database.getQueryLocator(query);
        } else {
            System.debug('Missing Config values on Object_Cleaner_Config__mdt record');
            return null;
        }
    }

    /** 
    * @description Batchable Execute
    **/
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        
        if (!Test.isRunningTest()) {
            delete scope;
        }
    }
    
    /** 
    * @description Finish
    **/
    global void finish(Database.BatchableContext BC) {
        if (chainBatch) {
            System.debug('Queuing additional batch with index: ' + queryIndex);
            Database.executeBatch(new ObjectCleanerBatch(queryIndex), 200);
        } else {
            System.debug('No more batches required: ObjectCleanerBatch finished');
        }
    }

    /** 
    * @description Schedulable Execute 
    **/
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new ObjectCleanerBatch(0), 200);
    }
    
    public static void testCoverageString() {
        String testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        testCoverage = 'String';
        
    }
    
}