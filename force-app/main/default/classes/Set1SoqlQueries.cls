public class Set1SoqlQueries {
    
    public list<account> GetRecordsTraditionalFor(){
        list<account>accList=[select name,rating from account]; 
        for(integer i=0;i<accList.size();i++){
            account acc=accList[i];
            system.debug(acc);
        }
        return accList;
    }
    public list<account> GetRecordsAdvFor(){
        list<account>accList=[select name,rating from account]; 
        for(account acc:accList){
        system.debug(acc);
        }
        return accList;
    }
    public list<account> GetRecordsWhileLoop(){
        list<account>accList=[select name,rating from account]; 
        integer i=0;
        while(i<accList.size()){
            account acc=accList[i];
            system.debug(acc);
            i++;
        }
        return accList;
    }
    
    public map<id,lead> getLeadRecord(){
        map<id,lead>leadIdMap=new map<id,lead>();
        list<lead>leadList=[select id,name,status from lead];
        for(lead le:leadList){
            leadIdMap.put(le.id,le);
        }
        system.debug('Lead ids are '+leadIdMap);
        return leadIdMap;
    }
    public list<account> UpdateContatCount(){
        list<account>updateList=new list<account>();
        list<contact>conList=[select id,name from contact where account.name='Eternus'];
        list<account>acclist=[select contactcount__c from account where name='Eternus'];
        for(account acc:acclist){
           acc.contactcount__c=conList.size(); 
        updateList.add(acc);
        }
        update updateList;
        return updateList;
    }
    /* on question 4 need clarification 
      whether it is lead or opportunity
    */
    public list<contact> ChildParentQuery(){
        list<contact>conList=[select id,lastname,account.name,account.phone,accountid from contact];
        system.debug('Related Records Information '+conList);
        return conList;
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