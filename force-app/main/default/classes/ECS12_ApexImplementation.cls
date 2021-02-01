public class ECS12_ApexImplementation {
      
    public static void makePrimeryContact(list<contact>newCont){
        set<id>AccIDset=new set<id>();
    for(contact con:newCont){
        if(con.AccountId!=null && con.PrimeryContact__c==true){
           AccIDset.add(con.AccountId); 
        }
        list<contact>conList=[select id,PrimeryContact__c from contact where accountid in:AccIDset];
        for(contact cont:conList){
            if(cont.PrimeryContact__c==true && cont.id!=trigger.oldmap.get(cont.id).id){
                for(contact c:newCont){
                    c.addError('There is Already a primery contact !!!');
                }
            }
        }
    }
    }
    
    public static void ContactAccountAssociation(list<contact>newCon){
        set<string>emailDomainset=new set<string>();
        for(contact cont:newCon){
            if(cont.Email!=null && cont.Accountid==null){
              emailDomainset.add(cont.email.split('@')[1]);  
            }
            
        }
        list<contact>conList=[select accountid,email from contact where primeryContact__c=true and accountid!=null];
        //set<string>ExistingEmailSet=new set<string>();
        for(contact ct:conList){
            
            if(emailDomainset.contains(ct.email.split('@')[1])){
              for(contact c:newCon){
                    c.accountid=ct.accountid;
                }  
            }
        }
       
    }
}