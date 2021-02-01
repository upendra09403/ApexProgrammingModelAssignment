@isTest
public class Test_ECS11ProgrammaticModel3Set2 {
 
    @isTest static void LeadCloneTest(){
        list<Lead>ledList=new list<Lead>();
        for(integer i=1;i<=10;i++){
        Lead led=new Lead();
        led.lastName='Test'+i;
            led.Company='Salesforce';
            ledList.add(led);
        }
            insert ledList;
        map<id,lead>ledMap=new map<id,lead>();
        for(lead ld:ledList){
            ledMap.put(ld.id,ld);
        }
        test.startTest();
        ECS_11_ProgrammaticModel_3Set2.cloneLead(ledMap);
        test.stopTest();
    }
    @istest static void caseTest(){
        account acc=new account();
        acc.Name='SLDS';
        acc.Email_Address__c='slds@gmail.com';
        insert acc;
        list<case>cslist=new list<case>();
        case cs=new case();
        cs.Status='New';
        cs.Origin='Web';
        cs.SuppliedEmail='slds@gmail.com';
        insert cs;
        cslist.add(cs);
        if(cs.SuppliedEmail==acc.Email_Address__c){
            cs.AccountId=acc.id;
            test.startTest();
            ECS_11_ProgrammaticModel_3Set2.EmailCheckCase(cslist);
            test.stopTest();
        }
    }
}