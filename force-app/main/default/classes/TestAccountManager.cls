@istest
public class TestAccountManager {

    @isTest static void testGetaccount() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://https://proseraa5-dev-ed.lightning.force.com/services/apexrest/account/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        map<string,string> thisacc = AccountManager.getAccount();
        // Verify results
        System.assert(thisacc != null);
        //System.assertEquals('Test record', thisCase.Subject);
    }
    
    static Id createTestRecord() {
        // Create test record
        account accTest = new account(
            name='Test record');
            
        insert accTest;
        return accTest.Id;
}
}