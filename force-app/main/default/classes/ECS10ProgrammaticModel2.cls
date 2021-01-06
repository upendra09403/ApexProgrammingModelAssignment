public class ECS10ProgrammaticModel2 {
    
    public void GetContactRecord(){
        list<contact>conList=[select lastname,phone,email from contact];
        for(contact con:conList){
            system.debug('Records information :'+con);
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
    public void MultiselectFilter(){
        list<account>accList=[select name from account where Enrollment_Year__c includes('2010')];
        system.debug('All account record for selected 2010 Enrollment year :'+accList);
        
        list<account>accList1=[select name from account where Enrollment_Year__c includes('2013;2014')];
        system.debug('All account record for selected 2013 and 2014 Enrollment year :'+accList1);
    }
    public void BillingStateFilter(){
        list<account>acclist=[select name,billingState from account where billingState NOT IN('Maharashtra','Kerala') order by billingState DESC NULLS LAST LIMIT:10000];
        for(account acc:acclist){
            system.debug(acc);
        }
        system.debug(acclist.size());
    }
    
    public void OpportunityRecords(){
        list<opportunity>oppList=[select name,amount from opportunity where amount>10000 
                                  order by CreatedDate Limit 100 OFFSET 50 ALL ROWS];
        for(opportunity opp:oppList){
            system.debug('Opportunity record information :'+opp);
        }
        system.debug(oppList.size());
    } 
    
    public void AggregateAmt(){
        List<AggregateResult> aggrList = [SELECT  SUM(Amount)Total ,CALENDAR_YEAR(CloseDate)year 
                                      FROM Opportunity WHERE isClosed=true and closedate=This_Fiscal_Year Group by  CALENDAR_YEAR(CloseDate)] ;
        Map<Integer , Decimal> SumtoYear = new Map<Integer,Decimal>() ;
        for(AggregateResult a : aggrList){
            SumtoYear.put((Integer)a.get('year'),(Decimal)a.get('Total')) ; 
        }
        System.debug('Sum Of Closed Opportunities amount :'+SumtoYear);
    }
    
    public void TotalDistinctLead(){
        List<AggregateResult> SumLead=[select count_distinct(name)Total ,leadSource 
                               from lead group by leadsource having count_distinct(name)>3];
        //Map<string,integer>leadMap=new Map<string,integer>();
        for(AggregateResult res:SumLead){
            integer countLead=(integer)res.get('Total');
            string StgName=(string)res.get('leadSource');
            system.debug('Leads per leadsource :'+StgName+' = '+countLead);
            //leadMap.put(StgName,countLead);
        }
        //system.debug(leadMap);
    }
    public void GroupByStatusLeadSource(){
        List<AggregateResult>AggrResult=[select count(name)Total,leadsource,status from lead group by leadsource,status];
        Map<string,map<string,integer>>leadMap=new Map<string,map<string,integer>>();
        map<string,integer>InnerMap=new map<string,integer>();
        for(AggregateResult res:AggrResult){
            InnerMap.put((string)res.get('status'),(integer)res.get('Total'));
            leadMap.put((string)res.get('leadsource'),InnerMap);
          /*string sts=(string)res.get('status');
            string src=(string)res.get('leadsource');
            integer count=(integer)res.get('Total');
            system.debug(src+', '+sts+', '+count); */
        }
        system.debug('Result is :'+leadMap);
    }
     //  Child To parent Query****
    //        
    public void GetContactMediaIndustry(){
        list<contact>conlist=[select name,account.name from contact where account.industry='Media'];
        for(contact con:conlist){
            system.debug('Contact Information :'+con.name+' account :'+con.account.name);
        }
    }
    public void ChildToParent(){
        for(c__c cobj:[select name,A__r.name,B__r.name from c__c where name like '%John%']){
            system.debug('Object c record :'+cobj+' Associated with A :'+cobj.A__r.name+' Associated With B :'+cobj.B__r.name);
        }
    }
    //Parent To child Query********
    //
    public void GetRecAccountToContact(){
        list<account>accList=[select name,(select name from contacts where name like '%John%')from account];
        for(account acc:accList){
            for(contact con:acc.contacts){
                system.debug('account :'+acc+' contact :'+con);
            }
        }
    }
    public void AccountToOpportunity(){
        list<account>acclist=[select name,(select name,stagename from opportunities where stagename='Closed Won')from account];
        for(account acc:acclist){
            for(opportunity opp:acc.opportunities){
                system.debug('For Account :'+acc.name+' Opportunity is :'+opp.name+' and stage is :'+opp.StageName);
            }
        }
    }
    
    Public void ParentToChildToParent(){
        list<A__c>Alist=[select name,(select name,B__r.name from Cs__r where name like '%John%')from A__c];
        for(A__c a:Alist){
            for(C__c c:a.Cs__r){
                system.debug('Object C record name :'+c.name+' Associated with Obj A :'+a.name+' Associated With B :'+c.B__r.name);
            }
        }
    }
    public void SoslQuery(){
        list<list<sobject>>multiObjectList=[find '*test*' in all fields returning contact(name),account(name),lead(name),user(name)];
        list<contact>conList=((list<contact>)multiObjectList[0]);
        list<account>accList=((list<account>)multiObjectList[1]);
        list<lead>LeadList=((list<lead>)multiObjectList[2]);
        list<user>userList=((list<user>)multiObjectList[3]);
        system.debug('Contact Search result :'+conList);
        system.debug('Account Search result :'+accList);
        system.debug('Lead Search result :'+LeadList);
        system.debug('User Search result :'+userList);
    }
    
    public void LeadInsertionErrorInsertion(){
        //Fetching the assignment rules on case
    AssignmentRule AR =[select id from AssignmentRule where SobjectType ='Lead' and Active=true limit 1];
    
    //Creating the DMLOptions for "Assign using active assignment rules" checkbox
      Database.DMLOptions dmlops=new Database.DMLOptions() ;
    dmlops.AssignmentRuleHeader.assignmentRuleId = AR.Id ;
    //preparing data to insert
        list<lead>leadlist=new list<lead>();
        for(integer i=1;i<=50;i++){
            lead le=new lead();
            le.LastName='Lead'+i;
            le.Company='ABCD'+i;
            le.City='Mumbai';
            le.setOptions(dmlops);
            leadlist.add(le);
        }
        for(integer i=1;i<=10;i++){
            lead le1=new lead();
            le1.LastName='Test'+i;
            //le.Company='ABCD'+i;
            le1.City='Mumbai';
            le1.setOptions(dmlops);
            leadlist.add(le1);
        }
        for(integer i=1;i<=50;i++){
            lead le2=new lead();
            le2.LastName='Test'+i;
            le2.Company='Wxyz'+i;
            le2.City='Pune';
            le2.setOptions(dmlops);
            leadlist.add(le2);
        }
        Database.SaveResult[] srresult=Database.insert(leadlist,false);
        for(Database.SaveResult sr:srresult){
            if(sr.isSuccess()){
                system.debug('Account Has been successfully inserted with id :'+sr.getId());
            }else{
                for(Database.Error err:sr.getErrors()){
                    system.debug('There is error while inserting status:'+err.getStatusCode() + 'Message :' + err.getMessage());
                    logs__c log=new logs__c();
                    log.Error__c=err.getMessage();
                    insert log;
                }
            }
        }
    }
    Public void Last90DaysRecords(){
        list<account>accList=[select id from account where Active__c='No' AND createdDate=Last_N_Days:90];
        delete accList;
    }
}