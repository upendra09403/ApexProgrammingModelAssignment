public class SoqlQueriesExClass {
  
    public void GetRecordsTraditionalFor(){
        list<account>accList=[select name,phone,rating,type,industry from account]; 
        for(integer i=0;i<accList.size();i++){
            account acc=accList[i];
            system.debug(acc);
        }
    }
    public void GetRecordsAdvFor(){
        list<account>accList=[select name,phone,rating,type,industry from account]; 
        for(account acc:accList){
        system.debug(acc);
        }
    }
    public void GetRecordsWhileLoop(){
        list<account>accList=[select name,phone,rating,type,industry from account]; 
        integer i=0;
        while(i<accList.size()){
            account acc=accList[i];
            system.debug(acc);
            i++;
        }
    }
    
    public set<id> getLeadRecord(){
        set<id>leadId=new set<id>();
        list<lead>leadList=[select id,name,status from lead];
        for(lead le:leadList){
            leadId.add(le.id);
        }
        system.debug('Lead ids are '+leadId);
        return leadId;
    }
    public void UpdateContatCount(){
        list<account>updateList=new list<account>();
        list<contact>conList=[select id,name from contact where account.name='Eternus'];
        list<account>acclist=[select contactcount__c from account where name='Eternus'];
        for(account acc:acclist){
           acc.contactcount__c=conList.size(); 
        updateList.add(acc);
        }
        update updateList;
        
    }
    /* on question 4 need clarification 
      whether it is lead or opportunity
    */
    public void ChildParentQuery(){
        list<contact>conList=[select id,lastname,account.name,account.phone,accountid from contact];
        system.debug('Related Records Information '+conList);
    }
    
    public list<account> getTodaysRecords(){
        list<account>acclist=[select id,name,phone,type,rating from account where createdDate=Today];
        system.debug(acclist);
        return acclist;
    }
    public void DatabaseDML(){
        list<account>acclist=new list<account>();
        account a1=new account();
        a1.name='Test1';
        acclist.add(a1);
        account a2=new account();
        a1.name='Test2';
        acclist.add(a2);
        account a3=new account();
        a1.rating='Hot';
        acclist.add(a3);
        //insert acclist;
        database.insert(acclist,false);
    }
   
}