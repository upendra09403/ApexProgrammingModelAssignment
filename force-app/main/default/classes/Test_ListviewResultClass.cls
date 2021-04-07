@isTest
public class Test_ListviewResultClass {

    @isTest static void testListViewData() {
    test.startTest(); 
    PageReference pageRef = Page.getSessionId;
      ListviewResultClass.fetchUserSessionId(); 
        test.stopTest();
        
    }
    @istest static void listviewName(){
        string objName='Account';
        list<listview> lstViewNames=[select Name from listview where sobjectType=:objName];
        system.assertEquals(lstViewNames, ListviewResultClass.getListViews('Account'));
    }
    @istest static void listViewDescribe(){
        test.startTest();
        string sobj='Account';
        string listName='All Accounts';
           Test.setMock(HttpCalloutMock.class, new Mock_ListViewResult()); 
    
        ListviewResultClass.ListViewDescribeResult resp=new ListviewResultClass.ListViewDescribeResult();
     resp = ListviewResultClass.getListViewdescribe(sobj,listName);
        test.stopTest();
       HttpRequest req = new HttpRequest();
        Mock_ListViewResult mock = new Mock_ListViewResult();
        HttpResponse res = mock.respond(req);
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        System.assertEquals(200, res.getStatusCode());
    }
    @istest static void listViewDataTest(){
        account acc=new account();
        acc.name='New This Week1';
        acc.phone='11111111';
        acc.Rating='Hot';
        acc.BillingState='KC';
        insert acc;
        string sobj='Account';
        string listName='New This Week';
        string query='select id,name,phone,billingstate,rating from account where createddate=This_week';
        list<sobject> recordsdata=database.query(query);
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new Mock_ListViewResult());
    ListviewResultClass.ListViewDataTable response=new ListviewResultClass.ListViewDataTable();
        response=ListviewResultClass.getListViewData(sobj,listName);
        test.stopTest();
    }
    @istest static void fetchRecords(){
        string objName='Account';
        string searchkey='Test';
        account acc=new account();
        acc.name='Test';
        acc.Phone='1012000';
        insert acc;
        contact con=new contact();
        con.lastname='Test Contact';
        insert con;
        lead le=new lead();
        le.lastname='New lead';
        le.Company='XYZ';
        le.LeadSource='Web';
        le.Status='New';
        insert le;
        opportunity opp=new opportunity();
        opp.name='Opp Test';
        opp.CloseDate=date.today();
        opp.StageName='Prospecting';
        insert opp;
        list<sobject> objList=new list<sobject>();
        objList.add(acc);
        objList.add(con);
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new Mock_ListViewResult());
        ListviewResultClass.fetchRecordsByName(searchkey,'Account');
        ListviewResultClass.fetchRecordsByName(searchkey,'Contact');
        ListviewResultClass.fetchRecordsByName(searchkey,'Lead');
        ListviewResultClass.fetchRecordsByName(searchkey,'Opportunity');
        ListviewResultClass.fetchRecordsByName(searchkey,' ');
        ListviewResultClass.updateRecord(objList);
        test.stopTest();
    }
}