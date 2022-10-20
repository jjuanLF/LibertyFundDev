public class SessionReadingsTriggerHandler {
    
    /** 
* @description This method is invoked from the SessionReadingsTrigger and calculates the Page_Count__c field based on the Pages__c field
*       It is called in the BeforeInsert/BeforeUpdate context
* @param lSessRdgs - Trigger context variable: newly inserted Session Readings records (Trigger.new)
*/ 
    public static void calculatePageCount(List<Session_Readings__c> lSessRdgs) {
        
        // Loop through all Session Readings records being updated
        for (Session_Readings__c oSessRdg : lSessRdgs) {
            
            decimal totalPages = 0;		// tallies the total number of pages across the entire Pages__c string
            
            // Only calculate the page count if: Pages__c string is not empty and Page_Count__c is null
            if (oSessRdg.Page_Count__c == null && oSessRdg.Pages__c != null) {
                integer charPtr = 0;		// counter to increment through the Pages__c steing
                integer length = oSessRdg.Pages__c.length();	// get the length of the Pages__c string
                boolean startRange = true;	// indicator of whether we are currently parsing the start or end range (i.e., start-end)
                decimal startPage = 0;		// variable into which parse the start page into
                decimal endPage = 0;		// variable into which parse the end page of a range
                decimal endOfPreviousRange = 0;	// holds the ending page of the previous range to avoid double-counting ranges that end/start on same page (i.e. 10-15, 15-20)
                
                // loop through the Pages__c field
                while (charPtr < length) {
                    
                    // get the character at the current string position
                    string currentChar = oSessRdg.Pages__c.mid(charPtr, 1);
                    
                    // if the current character is a numeric digit
                    if (currentChar == '0' || currentChar == '1' || currentChar == '2' || currentChar == '3' || currentChar == '4' || currentChar == '5' || currentChar == '6' || currentChar == '7' || currentChar == '8' || currentChar == '9') {
                        
                        // Add the current digit to either the startPage or endPage numer, based on which we are currently parsing
                        if (StartRange) {
                            startPage = (startPage * 10) + integer.valueof(currentChar);
                        } else {
                            endPage = (endPage * 10) + integer.valueof(currentChar);
                        }
                    // if the current character is a dash, we are moving from the start range to the end range                        
                    } else if (currentChar == '-') {
                            startRange = false;
                    // if the current character is a comma, we have completed a range and need to calculate the page count of the range and add it to  total pages
                    } else if (currentChar == ',') {
                                totalPages += endPage == 0 ? 1 : (endPage - startPage).abs() + 1;
                                // if the starting page of this range is the same as the ending page of the previous range, decrement total pages to avoid double-counting the page in common
                                if (startPage == endOfPreviousRange) {
                                    totalPages--;
                                }
                                // reset variables to begin parsing a new range
                                endOfPreviousRange = endPage;
                                startPage = 0;
                                endPage = 0;
                                startRange = true;
                            }
                    // move to the next character in the Pages string                    
                    charPtr += 1;
                }
                
                // at the end of string, we fall through and since the final range doesn't end with a comma, we need to perform the calculation for total pages on the final range
                totalPages += endPage == 0 ? 1 : (endPage - startPage).abs() + 1;
                
            }
            
            // set the value of total pages into the record                
            oSessRdg.Page_Count__c = totalPages;
            
        }
    }
}