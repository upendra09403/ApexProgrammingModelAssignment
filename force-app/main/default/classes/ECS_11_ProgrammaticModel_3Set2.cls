public class ECS_11_ProgrammaticModel_3Set2 {
    
    // Cloning of lead on assignment ECS_11_ProgrammaticModel_3Set2
    // question 3 trigger on lead name=TriggerOnLead
    public static void cloneLead(Map<id,lead>newLead){
        list<lead>leadList=new list<lead>();
        for(id key:newLead.keyset()){
            lead ld=new lead();
            ld=newLead.get(key).clone(false,false,false,false);
            leadList.add(ld);
        }
        insert leadList;
    }
    // Cloning of lead on assignment ECS_11_ProgrammaticModel_3Set2
    // question 4 trigger on lead name=ECS11Model3Set1TriggerAccount
    
    public static void TaskCreationAfterAccountInsert(map<id,account>newAccount){
        list<task>taskList=new list<task>();
        for(id key:newAccount.keyset()){
            task ts=new task();
            ts.subject='Meeting with '+newAccount.get(key).name;
            taskList.add(ts);
        }
        insert taskList;
    }
    public static void EmailCheckCase(list<case>newList){
        set<string>emaiSet=new set<string>();
        set<string>ExistingemaiSet=new set<string>();
        for(case cs:newList){
            if(cs.Origin=='Web' ||cs.Origin=='Email' ||cs.Origin=='Chat'){
                emaiSet.add(cs.SuppliedEmail);
            }
        }
        list<account>acclist=[select name,Email_Address__c from account where Email_Address__c in:emaiSet];
        if(acclist.size()>0){
        for(account acc:acclist){
            ExistingemaiSet.add(acc.Email_Address__c);
            for(case c:newList){
                c.AccountId=acc.id;
            }
        }
        }
    }
}