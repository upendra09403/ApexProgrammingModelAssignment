public class ECS11_ProgrammaticModel3Set3 {
    
    // cloning of opportunity trigger name=opportunityTrigger question no 3
    public static void cloneOpportunity(Map<id,opportunity>newOpp){
        list<opportunity>OppList=new list<opportunity>();
        for(id key:newOpp.keyset()){
            opportunity op=new opportunity();
            op=newOpp.get(key).clone(false,false,false,false);
            OppList.add(op);
        }
        insert OppList;
    }
    
    /* trigger on campaignMember object
     * question no 4 on assignment ECS-11_Programmatic Model - 3 Set 3
     */
    
    public static void campaignMember(list<campaignmember>cmpList){
        set<id>leadIdset=new set<id>();
        for(campaignmember cmr:cmpList){
            if(cmr.RSVP__c==false){
              leadIdset.add(cmr.leadid);  
            }
        }
        list<lead>leadList=[select id,LeadRSVP__c from lead where id in:leadIdset];
        for(campaignmember cm:cmpList){
            for(lead led:leadList){
                cm.RSVP__c=led.LeadRSVP__c;
            }
        }
    }
    public static void BillingToShipping(list<SalesHeader__c>newList){
        list<case>caseList=new list<case>();
        for(SalesHeader__c sh:newList){
          if((sh.Status__c=='Open' && sh.Pick_Status__c =='Open'&& sh.Total_Amount__c>=300)
                &&((sh.Bill_to_Street__c!=sh.Ship_to_Street__c)||
           (sh.Bill_to_City__c!= sh.Ship_to_City__c)||
           (sh.Bill_to_Postal_Code__c!= sh.Ship_to_Postal_Code__c)||
                   (sh.Bill_to_State__c != sh.Ship_to_State__c)) ){
                   case cs=new case();
                   cs.Accountid=sh.Bill_to_Customer__c;
                cs.contactid=sh.contact__c;
                cs.RecordType = [select Id from RecordType where Name = 'Assignment' and SobjectType = 'Case'];
                cs.Origin='Internal';
                
                cs.OwnerId =[select Id from Group where Name = 'AVS' AND Type = 'Queue'].id;
                cs.Reason='Address Did Not Verify';
                cs.Priority='High';
                cs.Status='New';
                cs.Type='Address Did Not Verify';
                cs.Subject=sh.Bill_to_Customer__c + ' ' + cs.Type;
                cs.open_sales_order__c=sh.id;
               // EFT_Transaction_Status__c ef=[select Transaction_Status__c,Transaction_Date__c from EFT_Transaction_Status__c where SalesHeader__c=:sh.id];
               // cs.Transaction_Status__c=ef.Transaction_Status__c;
                cs.Sales_Order_Number__c=sh.name;
               // cs.Order_Date__c=ef.Transaction_Date__c;
                caseList.add(cs);
               }
        }
        insert caseList;
    }
}