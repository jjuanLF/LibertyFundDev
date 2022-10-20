public class CitationTriggerHandler {
    
  /** 
    * @description This method sends newly created contacts to SiteStacker
    * Note: This method performs one callout PER contact passed to it as the SiteStacker API is not bulkified;
    *       It is called in the AfterInsert/AfterUpdate context
    * @param contacts - Trigger context variable: oldMap of contacts(Trigger.oldMap)
    * @param contacts - Trigger context variable: newly inserted contacts (Trigger.new)
    */ 
    public static void translateMarkdown(List<Citation__c> lCitations) {
        
        for (Citation__c oCitation : lCitations) {
            
            if (oCitation.Citation_Markdown__c != null) {
                integer charPtr = 0;
                integer length = oCitation.Citation_Markdown__c.length();
                boolean italicsActive = false;

	            // initialize Citation__c to an empty string
    	        oCitation.Citation__c = '';
                
                // loop through the Citataion_Markdown__c field
                while (charPtr < length) {
                    
                    string currentChar = oCitation.Citation_Markdown__c.mid(charPtr, 1);
                    system.debug('*** currentChar: ' + currentChar);
                    
                    // backslash
                    if (currentChar == '\\') {
                        if (charPtr < (length-1)) { // make sure we're not sitting on the last character
                            string nextChar = oCitation.Citation_Markdown__c.mid(charPtr+1, 1);
                            if (nextChar == 'n') {
                                oCitation.Citation__c += '<br>';
                            } else {
                                oCitation.Citation__c += nextChar;
                            }
                            charPtr += 1; // bump past the \
                        }
                    
                    // Italics (underscore or asterisk)
                    } else if ((currentChar == '_') || (currentChar == '*')) {
                        if (!italicsActive) {
	                    	oCitation.Citation__c += '<i>';
                        } else {
    	                	oCitation.Citation__c += '</i>';
                        }
                        // toggle italics flag
                    	italicsActive = !italicsActive;

                    // passthru char
                    } else {
                    	oCitation.Citation__c += currentChar;
                    }
                    
                    charPtr += 1;	// move to the next character
                }
            }
            system.debug('**** Citation__c: ' + oCitation.Citation__c);
        }
    }
}