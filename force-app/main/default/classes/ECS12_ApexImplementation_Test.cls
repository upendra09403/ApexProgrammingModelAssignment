@isTest
private class ECS12_ApexImplementation_Test {
    @isTest static void checkPrimeryContact(){
        account acc=new account();
        acc.name='Test1';
        insert acc;
        list<contact>conList=new list<contact>();
        contact con=new contact();
        con.AccountId=acc.id;
        con.LastName='Test Contact1';
        con.primeryContact__c=true;
        conList.add(con);
        contact co=new contact();
        co.AccountId=acc.id;
        co.LastName='Test Contact2';
        co.PrimeryContact__c=true;
        conList.add(co);
        insert conList;
        test.startTest();
        list<contact>con1=[select id,accountid,lastname,primeryContact__c from contact where id in:conList order by id];
        for(contact c:con1){
            system.assertEquals(acc.id, c.AccountId);
            system.assertEquals(c.primeryContact__c, true);
        }
        test.stopTest();
    }
    @isTest static void domainCheckmethod(){
        List<Account> accList=new List<Account>();
        Integer count=10;
        for(Integer i=1;i<=count;i++)
        {
            accList.add(new Account(Name='My Account '+i));
        }
        insert accList;
        List<Contact> contList=new List<Contact>();
        for(Integer i=0;i<count;i++)
        {
            contList.add(new Contact(Email='contact@gmail'+i+'.com',primeryContact__c=true,accountid=accList[i].id,LastName='Contacter '+i));
        }
        insert contList;
        list<contact> coList=new List<contact>();
        for(integer i=0;i<count;i++){
            coList.add(new Contact(Email='Test@gmail'+i+'.com',lastname='Testing '+i));
        }
        insert coList;
        test.startTest();
        List<Contact> res=[Select Id,AccountId,lastname From Contact Where lastname like'Testing%' order by id];
        system.assertEquals('Testing 0', res[0].lastname);
        
        test.stopTest();
    }
}