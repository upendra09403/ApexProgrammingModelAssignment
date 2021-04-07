@isTest
global class Mock_ListViewResult implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
         HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        //response.setBody('{"LastName":"Test"}');
        response.setStatus('OK');
        response.setBody('{"sessionId":"dddsadasxsaxasxasx","instance_url":"https://login.salesforce.com"}');
        response.setStatusCode(200);
        return response; 
    }
}