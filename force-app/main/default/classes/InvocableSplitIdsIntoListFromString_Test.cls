@isTest
private class InvocableSplitIdsIntoListFromString_Test {
	@isTest
    private static void validateStringToList(){
        String lwcIdString = '0032h00000f6RZHAA2, 0032h00000hH3UlAAK, 0032h00000fj2xiAAA';
        List<String> listStringInputs = new List<String>();
        listStringInputs.add(lwcIdString);
        InvocableSplitIdsIntoListFromString.Request testRequest = new InvocableSplitIdsIntoListFromString.Request();
        testRequest.listWithIdAsString = listStringInputs;
        List<InvocableSplitIdsIntoListFromString.Request> listTestRequests = new List<InvocableSplitIdsIntoListFromString.Request>();
        listTestRequests.add(testRequest);
        Test.startTest();
        List<InvocableSplitIdsIntoListFromString.Result> listTestResults = InvocableSplitIdsIntoListFromString.splitStringIntoList(listTestRequests);
        Test.stopTest();
        System.assertEquals(3,listTestResults[0].listIds.size(),'The single initial string should return a list a 3 strings');
    }
}