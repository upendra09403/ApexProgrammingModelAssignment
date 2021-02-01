public class ECS11Model3Set1 {
    //To check debuglog for trigger ECS11Model3Set1TriggerAccount************
    public static void checkDebugAccount(list<account>acclist){
        for(account acc:acclist){
            system.debug(acc.name);
        }
    }
    public static void checkDebugAccountForMap(Map<id,account>acclist){
        Map<id,string>accMap=new Map<id,string>();
        for(id key:acclist.keyset()){
          accMap.put(key,acclist.get(key).name) ;
            system.debug(accMap);
        }
    }
    //To check debuglog in contact trigger************
    public static void checkDebugContact(list<contact>conList){
        for(contact con:conList){
            system.debug(con.lastname);
        }
    }
    public static void checkDebugContactForMap(Map<id,contact>conlist){
        Map<id,string>ConMap=new Map<id,string>();
        for(id key:conlist.keyset()){
          ConMap.put(key,conlist.get(key).lastname) ;
            system.debug(ConMap);
        }
    }
    //To clone account record through account trigger
    public static void cloneAccount(Map<id,account>newAccount){
        list<account>actList=new list<account>();
        for(id key:newAccount.keyset()){
            account act=new account();
            act=newAccount.get(key).clone(false,false,false,false);
            actList.add(act);
        }
        insert actList;
    }
    
    //Prevent duplicate Contact triggername=ECS11Model3Set1TriggerContact*********** 
    public static void preventDuplicateContact(list<contact>ConList){
        set<string>EmailIdSet=new set<string>();
        set<string>PhoneNoSet=new set<string>();
        set<string>ExistingEmailSet=new set<string>();
        set<string>ExistingPhoneSet=new set<string>();
        for(contact con:ConList){
            
            EmailIdSet.add(con.Email);
            PhoneNoSet.add(con.Phone);
            
        }
        for(contact con:[select name,phone,email from contact where phone in:PhoneNoSet OR email in:EmailIdSet]){
            if(con.Email!=null){
             ExistingEmailSet.add(con.email);   
            }
            if(con.phone!=null){
              ExistingPhoneSet.add(con.Phone);  
            }  
        }
        for(contact con:ConList){
            if((ExistingEmailSet.contains(con.email))||(ExistingPhoneSet.contains(con.phone))){
                con.addError('A Contact with the same email address or phone number already exists in system.');
            }
        }
    }
    //trigger handler method for EFT_Transaction_Status__c object 
    //question no five of assignment ECS11Programmatic model3 set1
    //
    public static void EFTTransactionStatusInsert(map<id,EFT_Transaction_Status__c>newMaplist){
        list<case>caseList=new list<case>();
            for(EFT_Transaction_Status__c ef:[select name,Transaction_Status__c,Method_Name__c,Transaction_Date__c,
            salesHeader__r.status__c,SalesHeader__r.Bill_to_Customer__c,SalesHeader__r.contact__c,SalesHeader__r.name,
                SalesHeader__r.Bill_to_Customer__r.name from EFT_Transaction_Status__c where id in:newMaplist.keyset()]){
            if((ef.Transaction_Status__c=='Declined')&&(ef.Method_Name__c=='Credit Card Address Verify')&&(ef.salesHeader__r.status__c=='Open')){
               case cs=new case(); 
                cs.Accountid=ef.SalesHeader__r.Bill_to_Customer__c;
                cs.contactid=ef.SalesHeader__r.contact__c;
                cs.RecordType = [select Id from RecordType where Name = 'Assignment' and SobjectType = 'Case'];
                cs.Origin='Internal';
                
                cs.OwnerId =[select Id from Group where Name = 'AVS' AND Type = 'Queue'].id;
                cs.Reason='Address Did Not Verify';
                cs.Priority='High';
                cs.Status='New';
                cs.Type='Address Did Not Verify';
                cs.Subject=ef.SalesHeader__r.Bill_to_Customer__r.name + ' ' + cs.Type;
                cs.open_sales_order__c=ef.SalesHeader__r.id;
                cs.Transaction_Status__c=ef.Transaction_Status__c;
                cs.Sales_Order_Number__c=ef.SalesHeader__r.name;
                cs.Order_Date__c=ef.Transaction_Date__c;
                caseList.add(cs);
            }
            
        }
        insert caseList;
    }
}