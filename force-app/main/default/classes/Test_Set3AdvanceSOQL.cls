@isTest
public class Test_Set3AdvanceSOQL {
    @istest static void getContact(){
        contact con=new contact();
        con.LastName='Test';
        insert con;
        list<contact>conlist=[select id,lastname from contact where id=:con.id];
        test.startTest();
        Set3AdvanceSOQL st=new Set3AdvanceSOQL();
        st.GetContactRecord();
        test.stopTest();
        system.assertEquals('Test', conlist[0].lastname);
    }
    @istest static void accountContactRec(){
        account acc=new account();
        acc.Name='Account Test';
        insert acc;
        contact con=new contact();
        con.LastName='Test';
        con.AccountId=acc.id;
        insert con;
        list<account>accList=[select name,(select id,lastname from contacts)from account];
        test.startTest();
        Set3AdvanceSOQL st=new Set3AdvanceSOQL();
        st.GetContactRecord();
        st.ParentChildRelationship();
        st.AssociatedContactOfAccount();
        test.stopTest();
    }
    @isTest static void createRecords(){
        account acc=new account();
        acc.Name='Account Test';
        insert acc;
        contact con=new contact();
        con.LastName='Test';
        con.AccountId=acc.id;
        insert con;
        lead led=new lead();
        led.lastname='Lead Test';
        led.Company='Salesforce';
        insert led;
        opportunity opp=new opportunity();
        opp.name='Opp Test';
        opp.StageName='Prospecting';
        opp.CloseDate=date.Today().adddays(15);
        insert opp;
        test.startTest();
        Set3AdvanceSOQL st=new Set3AdvanceSOQL();
        st.CreateNewRecords();
        test.stopTest();
    }
    @istest static void userRec(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        user u=new user(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='standard@upblue.com');
        insert u;
        list<user>UserList=[select id,name,username,alias,email from user where id=:u.id];
        Map<id,User>UserMap=new Map<id,User>();
        UserMap.put(UserList[0].id,UserList[0]);
        test.startTest();
        Set3AdvanceSOQL st=new Set3AdvanceSOQL();
        st.GetActiveUserRecords();
        test.stopTest();
        
    }
    @istest static void prepareMapTest(){
        list<account>acclist=new list<account>();
        for(integer i=1;i<=10;i++){
            account acc=new account();
            acc.Name='Test'+i;
            acclist.add(acc);
        }
        insert acclist;
        map<id,account>accMap=new map<id,account>();
        for(account acc1:acclist){
          accMap.put(acc1.id,acc1);  
        }
        test.startTest();
        Set3AdvanceSOQL st=new Set3AdvanceSOQL();
        st.prepareMapStructure();
        test.stopTest();
    }
}