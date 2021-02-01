@isTest
public class Test_Set2AdvanceSOQL {

    @isTest static void GettingOpportunityTest(){
        list<opportunity>oppList=new List<opportunity>();
        for(integer i=1;i<=5;i++){
        opportunity opp=new opportunity();
            opp.Name='Opp'+i;
            opp.StageName='Prospecting';
            opp.CloseDate=date.today().adddays(15);
            oppList.add(opp);
            }
        insert oppList;
        test.startTest();
        Set2AdvanceSOQL st=new Set2AdvanceSOQL();
        st.GetOpportunityRecords();
        st.AccountStartsWithA();
        test.stopTest();    
    }
    @isTest static void AccOppMapTest(){
        account acc=new account();
        acc.Name='Test Account';
        insert acc;
        list<opportunity> opplist=new list<opportunity>();
        for(integer i=1;i<=10;i++){
            opportunity opp=new opportunity();
            opp.Name='Opp'+i;
            opp.StageName='Prospecting';
            opp.CloseDate=date.today();
            opp.AccountId=acc.id;
            opplist.add(opp);
        }
        insert opplist;
        Set2AdvanceSOQL st=new Set2AdvanceSOQL();
        st.AccountOppMap();
        st.getCampaigns();
    }
    @istest static void getContact(){
        contact con=new contact();
        con.LastName='Test';
        insert con;
        list<contact>conList=[select id,lastname from contact where lastModifiedDate=today];
        Set2AdvanceSOQL st=new Set2AdvanceSOQL();
        st.getContactRecord();
        system.assertEquals(con.id, conList[0].id);
    }
}