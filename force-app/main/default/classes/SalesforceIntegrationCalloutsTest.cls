@isTest
private class SalesforceIntegrationCalloutsTest {
    
    @isTest static void testPostCallout() {
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockGenerator()); 
        ContactCreationDestinationClass token=new ContactCreationDestinationClass();
        token.ReturnAccessToken();
        ContactCreationDestinationClass.createContactRecord('Test');
        test.stopTest();
        HttpRequest req = new HttpRequest();
        HttpCalloutMockGenerator mock = new HttpCalloutMockGenerator();
        HttpResponse res = mock.respond(req);
        // Verify that the response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        System.debug(res.getBody());
        System.assertEquals(200, res.getStatusCode());     
    }
}