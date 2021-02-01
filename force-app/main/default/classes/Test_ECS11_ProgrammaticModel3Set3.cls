@isTest
public class Test_ECS11_ProgrammaticModel3Set3 {

    @istest static void cloneRecordTest(){
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
        map<id,opportunity>oppMap=new map<id,opportunity>();
        for(opportunity op:oppList){
            oppMap.put(op.id,op);
        }
        test.startTest();
        ECS11_ProgrammaticModel3Set3.cloneOpportunity(oppMap);
        test.stopTest();        
    }
    @istest static void campaignMemberTest(){
        lead led=new lead();
        led.lastname='Test';
        led.Company='Salesforce';
        led.LeadRSVP__c=true;
        insert led;
        lead led1=new lead();
        led1.lastname='Test 1';
        led1.Company='Salesforce';
        led1.LeadRSVP__c=true;
        insert led1;
        campaign cp=new campaign();
        cp.name='Camp';
        insert cp;
        list<campaignMember> cmList=new list<campaignmember>();
        campaignMember cm=new campaignmember();
        cm.CampaignId=cp.id;
        cm.RSVP__c=false;
        cm.LeadId=led.id;
        cmList.add(cm);
        campaignMember cm1=new campaignmember();
        cm1.CampaignId=cp.id;
        cm1.RSVP__c=true;
       cm1.LeadId=led1.id;
        cmList.add(cm1);
        insert cmList;
        if(cm.RSVP__c==false){
            cm.RSVP__c=led.LeadRSVP__c;
        }
        update cm;
        test.startTest();
    ECS11_ProgrammaticModel3Set3.campaignMember(cmList);
    test.stopTest();
    }
    @istest static void newCaseTest(){
        list<SalesHeader__c> slList=new list<SalesHeader__c>();
        for(integer i=1;i<=5;i++){
          SalesHeader__c sh=new SalesHeader__c();
            sh.Status__c='Open';
            sh.Pick_Status__c ='Open';
            sh.Total_Amount__c=500+i;
            sh.Bill_to_Street__c='Number'+i;
            sh.Bill_to_City__c='Agra';
            sh.Bill_to_Postal_Code__c=10101+i;
            sh.Bill_to_State__c='CY';
            sh.Ship_to_State__c='NY';
            slList.add(sh);
        }
        insert slList;
        test.startTest();
        ECS11_ProgrammaticModel3Set3.BillingToShipping(slList);
        test.stopTest();
    }
}