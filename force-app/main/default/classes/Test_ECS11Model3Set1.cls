@isTest
public class Test_ECS11Model3Set1 {
  
    @isTest static void DebugAccountTest(){
        map<id,account>mapAcc=new map<id,account>();
        list<account>acclist=new list<account>();
        for(integer i=1;i<=10;i++){
            account ac=new account();
            ac.name='Test'+i;
            acclist.add(ac);
            mapAcc.put(ac.id,ac);
        }
        insert acclist;
        test.startTest();
        ECS11Model3Set1.checkDebugAccount(acclist);
        ECS11Model3Set1.checkDebugAccountForMap(mapAcc);
        test.stopTest();
    }
    @isTest static void DebugContactTest(){
        map<id,contact>mapCon=new map<id,contact>();
        list<contact>Conlist=new list<contact>();
        for(integer i=1;i<=10;i++){
            contact ac=new contact();
            ac.lastname='Test'+i;
            Conlist.add(ac);
            mapCon.put(ac.id,ac);
        }
        insert Conlist;
        test.startTest();
        ECS11Model3Set1.checkDebugContact(Conlist);
        ECS11Model3Set1.checkDebugContactForMap(mapCon);
        test.stopTest();
    }
    @istest static void accountCloneTest(){
        list<account>accList=new list<account>();
        for(integer i=1;i<=10;i++){
        account acc=new account();
        acc.Name='Test'+i;
            accList.add(acc);
        }
            insert accList;
        map<id,account>accMap=new map<id,account>();
        for(account ac:accList){
            accMap.put(ac.id,ac);
        }
        test.startTest();
        ECS11Model3Set1.cloneAccount(accMap);
        test.stopTest();
    }
    @istest static void preventDuplicateContactTest(){
        list<contact>conList=new list<contact>();
        contact con=new contact();
        con.lastname='Test';
        con.Phone='000000';
        con.Email='Test@gmail.com';
        conList.add(con);
        contact con1=new contact();
        con1.lastname='Test2';
        con1.Phone='000000';
        con1.Email='Test@gmail.com';
        conList.add(con1);
        insert conList;
        if(con.phone==con1.phone ||con.Email==con1.Email){
            con1.adderror('');
        }
        test.startTest();
        ECS11Model3Set1.preventDuplicateContact(conList);
        test.stopTest();
    }
    @istest static void EFTTransactionStatusInsertTest(){
        map<id,EFT_Transaction_Status__c>newMap=new map<id,EFT_Transaction_Status__c>();
        SalesHeader__c sh=new SalesHeader__c();
            sh.Status__c='Open';
            sh.Pick_Status__c ='Open';
            sh.Total_Amount__c=500;
            insert sh;
        EFT_Transaction_Status__c ef=new EFT_Transaction_Status__c();
        ef.name='Test Transaction';
        ef.Transaction_Status__c='Declined';
        ef.Method_Name__c='Credit Card Address Verify';
        ef.SalesHeader__c=sh.id;
        insert ef;
        newMap.put(ef.id,ef);
        test.startTest();
    ECS11Model3Set1.EFTTransactionStatusInsert(newMap);
    test.stopTest();  
    }
    
}