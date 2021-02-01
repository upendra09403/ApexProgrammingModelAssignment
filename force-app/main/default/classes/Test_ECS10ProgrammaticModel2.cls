@isTest
public class Test_ECS10ProgrammaticModel2 {
 @istest static void getContact(){
        contact con=new contact();
        con.LastName='Test';
        insert con;
        list<contact>conlist=[select id,lastname from contact where id=:con.id];
        test.startTest();
        ECS10ProgrammaticModel2 ec=new ECS10ProgrammaticModel2();
        ec.GetContactRecord();
        ec.GetContactMediaIndustry();
         ec.ChildToParent();
        test.stopTest();
        system.assertEquals('Test', conlist[0].lastname);
    }
    @istest static void userRecord(){
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
        ECS10ProgrammaticModel2 ec=new ECS10ProgrammaticModel2();
        ec.GetActiveUserRecords();
        test.stopTest();    
    }
    @istest static void prepareMapTestmethod(){
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
        ECS10ProgrammaticModel2 ec=new ECS10ProgrammaticModel2();
        ec.prepareMapStructure();
        test.stopTest();
    }
    @istest static void multiselectFilterTest(){
        list<account>acclist=new list<account>();
        account acc=new account();
            acc.Name='Test';
            acc.Enrollment_Year__c='2010';
            acc.BillingState='Maharashtra';
         acclist.add(acc);
       account acc1=new account();
        acc1.name='Test 2';
        acc1.Enrollment_Year__c='2013;2014';
        acc1.BillingState='Kerala';
        acclist.add(acc1);
       account acc2=new account();
        acc2.name='Test 3';
        acc2.Enrollment_Year__c='2014';
        acc2.BillingState='Delhi';
        acclist.add(acc2);
        insert acclist;
        test.startTest();
        ECS10ProgrammaticModel2 ec=new ECS10ProgrammaticModel2();
        ec.MultiselectFilter();
        ec.BillingStateFilter();
        test.stopTest();
        system.assertEquals('Test', [select name from account where Enrollment_Year__c includes('2010')].name);
        system.assertEquals('Test 2', [select name from account where Enrollment_Year__c includes('2013;2014')].name);
        system.assertEquals('Test 3', [select name,billingState from account where billingState NOT IN('Maharashtra','Kerala') order by billingState DESC NULLS LAST LIMIT:100].name);
    }
    @istest static void oppRecord(){
        list<opportunity>oppList=new list<opportunity>();
        for(integer i=1;i<=10;i++){
            opportunity opp=new opportunity();
            opp.Name='Test'+i;
            opp.Amount=11000;
            opp.StageName='Prospecting';
            opp.CloseDate=date.today();
            oppList.add(opp);
        }
        insert oppList;
        test.startTest();
        ECS10ProgrammaticModel2 ec=new ECS10ProgrammaticModel2();
        ec.OpportunityRecords();
        ec.AggregateAmt();
        test.stopTest();
    }
    @istest static void testlead(){
        list<lead>ledList=new list<lead>();
        for(integer i=1;i<=10;i++){
        lead led=new lead();
        led.LastName='Test Lead'+i;
        led.Company='SFDC';
            led.LeadSource='Phone';
            ledList.add(led);
        }
        insert ledList;
        List<AggregateResult> SumLead=[select count_distinct(name)Total ,leadSource 
                                       from lead group by leadsource having count_distinct(name)>3];
        test.startTest();
        ECS10ProgrammaticModel2 ec=new ECS10ProgrammaticModel2();
        ec.TotalDistinctLead();
        ec.GroupByStatusLeadSource();
        test.stopTest();     
    }
    @istest static void relationshipQueryTest(){
        account acc=new account();
        acc.name='Test R';
        insert acc;
        contact con=new contact();
        con.LastName='Con R';
        con.AccountId=acc.id;
        insert con;
        opportunity opp=new opportunity();
        opp.name='Opp R';
        opp.StageName='Prospecting';
        opp.CloseDate=date.today();
        opp.AccountId=acc.id;
        insert opp;
        test.startTest();
        ECS10ProgrammaticModel2 ec=new ECS10ProgrammaticModel2();
        ec.GetRecAccountToContact();
        ec.AccountToOpportunity();
        ec.Last90DaysRecords();
        test.stopTest();
    }
    @istest static void manyToManyTest(){
        A__c a=new A__c();
        a.name='Model A';
        insert a;
        B__c b=new B__c();
        b.name='Model B';
        insert b;
        C__c c=new C__c();
        c.name='Model C';
        c.A__c=a.Id;
        c.B__c=b.id;
        insert c;
        test.startTest();
        ECS10ProgrammaticModel2 ec=new ECS10ProgrammaticModel2();
        ec.ParentToChildToParent();
        ec.SoslQuery();
        ec.LeadInsertionErrorInsertion();
         test.stopTest();
        
    }
}