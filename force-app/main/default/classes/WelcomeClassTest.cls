@isTest
public class WelcomeClassTest {

    @isTest private static void showMessage(){
        system.debug('This is my test method');
        WelcomeClass.welcome();
    }
    
    @isTest private static void newContact(){
        account acc=new account();
        acc.name='Test1';
        insert acc;
        contact con=new contact();
        con.lastname='Test Contact';
        con.accountid=acc.id;
        insert con;
    }
}