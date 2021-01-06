public class Set2AdvanceSOQL {

    public void GetOpportunityRecords(){
        list<id>OppIdList=new list<id>();
        set<id>OppIdSet=new set<id>();
        Map<id,id>OppIdMap=new Map<id,id>();
        list<opportunity>OppList=[select id,name,accountid from opportunity where accountid!=null AND Stagename='Closed Won'];
        for(opportunity Opp:OppList){
           OppIdList.add(opp.id);
           OppIdSet.add(opp.id); 
            OppIdMap.put(opp.id,opp.accountid);
        }
        system.debug('List Ids Result is '+OppIdList);
        system.debug('List Ids Result is '+OppIdSet);
        system.debug('List Ids Result is '+OppIdMap);
    }
    public void AccountStartsWithA(){
        list<account>UpdatedAccount=new list<account>();
        list<account>AccList=[select id,name from account where name like 'a%'];
        integer NumberOfAcc=AccList.size();
        system.debug('No of records are '+NumberOfAcc);
        for(account acc:AccList){
            acc.name='‘Updated via update DML operation';
            UpdatedAccount.add(acc);
        }
        update UpdatedAccount;
    }
    public void AccountOppMap(){
        Map<id,list<id>>AccountOppIDMap=new Map<id,list<id>>();
        list<id>idlist=new list<id>();
        list<opportunity>OppList=[select id,accountid from opportunity where accountid!=null];
        for(opportunity opp:OppList){
            idlist.add(opp.accountid);
        }
        list<account>acclist=[select id,name,(select id,name from opportunities)from account where id in:idlist];
        list<id>idlist1=new list<id>();
        for(account acc:acclist){
            for(opportunity opp1:acc.opportunities){
                idlist1.add(opp1.id);
            }
            AccountOppIDMap.put(acc.id,idlist1);
            
        }
        system.debug(AccountOppIDMap);
    }
    
    public void getCampaigns(){
       list<campaign>getList=[select name from campaign];
        for(campaign cam:getList){
            system.debug('Campaign records are '+cam);
        }
        system.debug('***************Ascending Order**************');
        getList.sort();
        for(campaign camp:getList){
            system.debug('Campaign records are '+camp);
        }
        system.debug('**************Descending Order*****************');
        for(integer i=getList.size()-1;i>=0;i--){
            system.debug('Campaign records are '+getList[i]);
        }
    }
    
    public void getContactRecord(){
        list<contact>conList=[select id,lastname from contact where lastModifiedDate=today];
        for(contact con:conList){
            system.debug('Todays modified contact records are '+con);
        }
        
    }  
        
        
        
        
        }