global class InvocableSplitIdsIntoListFromString {

    @InvocableMethod(label='Split Ids as String Into List of Ids' category='Util')
    global static List<Result> splitStringIntoList(List<Request> requestList){
       	List<Result> results = new List<Result>();
        for (Request request: requestList) {
        	System.debug('listWithIdAsString: ' + request.listWithIdAsString[0]);
            //Ensure no duplicate Ids; split using comma-space as separator
        	Set<String> setIds = new Set<String>(request.listWithIdAsString[0].split(', '));
            Result result = new Result();
            result.listIds = new List<String>(setIds);
            System.debug('listIds[0]: ' + result.listIds[0]);
            results.add(result);
        }
        return results;
    }

	global class Request {
		@InvocableVariable(description='First item is comma-delimited string of Ids' required=true)
		global List<String> listWithIdAsString;
	}
        
	global class Result {
		@InvocableVariable
		global List<String> listIds;
	}
}