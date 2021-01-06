public class Set3AdvanceSOQL {
    public void GetContactRecord(){
        list<contact>conList=[select id,lastname from contact];
        for(contact con:conList){
            system.debug('Contact Records Are :'+con);
        } 
    }
    public void AssociatedContactOfAccount(){
        list<account>accList=[select name,(select id,lastname,Email from contacts)from account];
        for(account acc:accList){
            system.debug('Account Record :'+acc);
            for(contact con:acc.contacts){
                system.debug('contact records Associated to above account are :'+con);
            }
            system.debug('******************************');
        }
    }
    Public void CreateNewRecords(){
        //Acount creation******
        Account acc=new account();
        acc.name='Account Through Apex';
        acc.phone='12312312';
        insert acc;
        
        //Contact Creation*********
        contact con=new contact();
        con.LastName='Contact Through Apex';
        insert con;
        
        //Lead Creation***********
        lead led=new lead();
        led.lastname='Lead Through Apex';
        led.Company='Salesforce';
        insert led;
        
        //Opportunity Creation**********
        opportunity opp=new opportunity();
        opp.name='Opportunity through Apex';
        opp.StageName='Prospecting';
        opp.CloseDate=date.Today().adddays(15);
        insert opp;
    }
    public void ParentChildRelationship(){
        list<account>acclist=[select name,phone,(select lastname,email from contacts)from account];
        for(account acc:acclist){
            system.debug('Account Records are :'+acclist);
            for(contact con:acc.contacts){
                system.debug('Contact Records are :'+con);
            }
            system.debug('**************************************');
        }
    }
    
    public void GetActiveUserRecords(){
        Map<id,User>UserMap=new Map<id,User>();
        list<user>UserList=[select id,name,username,alias,email from user where isActive=true];
        for(user u:userlist){
            UserMap.put(u.id,u);  
        }
        for(id key:UserMap.keyset()){
           system.debug('User detail of this userid is  :'+UserMap.get(key)); 
        }
    }
    public void prepareMapStructure(){
       /*  it gives system.stringException invalid id-
        * on searching error--You can not assign an invalid ID to an ID field - either the 
        * primary key or a foreign key (relationship field). For example you can't set the 
        * AccountID field value on Contact to "Acme Corp" and expect the system to resolve it for you automatically.
        
        Map<string,id>AccMap1=new Map<string,id>();
        list<account>acclist=[select id,name from account];
        for(account acc:acclist){
            AccMap1.put(acc.name,acc.id);
        }
        for(id key:AccMap1.keyset()){
            system.debug('For AccountId :'+key+' AccountId is :'+AccMap1.get(key));
        }
        */
        Map<id,Account>AccMap1=new Map<id,Account>();
        list<account>acclist=[select id,name from account];
        for(account acc:acclist){
            AccMap1.put(acc.id,acc);
        }
        for(id key:AccMap1.keyset()){
            system.debug('For AccountId :'+key+' Account Information is :'+AccMap1.get(key));
        } 
    }
    
}