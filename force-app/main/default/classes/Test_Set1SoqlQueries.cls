@isTest
public class Test_Set1SoqlQueries {

    @istest static void gettingAccount(){
        account acc=new account();
        acc.name='Test';
        acc.Rating='Hot';
        insert acc;
        test.startTest();
        Set1SoqlQueries st=new Set1SoqlQueries();
        st.GetRecordsTraditionalFor();
        st.GetRecordsAdvFor();
        st.GetRecordsAdvFor();
        st.GetRecordsWhileLoop();
        test.stopTest();
        system.assertEquals('Test', [select name from account where id=:acc.id].name);
    }  
    @istest static void getLeads(){
        lead led=new lead();
        led.LastName='Test';
        led.Company='ABCD';
        insert led;
        test.startTest();
        Set1SoqlQueries st=new Set1SoqlQueries();
        st.getLeadRecord();
        test.stopTest();
        system.assertEquals('Test', [select lastname from lead where id=:led.id].lastname);
    }
    @isTest static void updateCount(){
        account acc=new account();
        acc.name='Something';
        insert acc;
        contact con=new contact();
        con.lastname='Something Con';
        con.AccountId=acc.id;
        insert con;
        acc.ContactCount__c=[select name from contact where accountid=:acc.id].size();
        update acc;
        test.startTest();
        Set1SoqlQueries st=new Set1SoqlQueries();
        st.UpdateContatCount();
        st.ChildParentQuery();
        test.stopTest();
        system.assertEquals(1, acc.ContactCount__c);
    }
    @istest static void getTodaysRecord(){
        account acc=new account();
        acc.name='Something';
        insert acc;
        test.startTest();
        Set1SoqlQueries st=new Set1SoqlQueries();
        st.getTodaysRecords();
        test.stopTest();
        system.assertEquals('Something', acc.name);
    }
    @istest static void DatabasedmlMethods(){
        list<account>accList=new list<account>();
        account acc=new account();
        acc.name='Something';
        accList.add(acc);
        account acc1=new account();
        acc1.rating='Hot';
        accList.add(acc1);
        database.insert(accList,false);
        test.startTest();
        Set1SoqlQueries st=new Set1SoqlQueries();
        st.DatabaseDML();
        test.stopTest();
    }
}