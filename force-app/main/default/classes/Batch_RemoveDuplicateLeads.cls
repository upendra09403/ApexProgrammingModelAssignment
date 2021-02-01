global class Batch_RemoveDuplicateLeads implements database.Batchable<sobject>{
 global Set<String> emailstring;
  global  Map<String,lead> EmailBookmap = new Map<String,lead>();
    string query;
    global Database.QueryLocator start(Database.BatchableContext BC){
        query='select name,email from lead where email!=null';
      return Database.getQueryLocator(query);
      }
    
    global void execute(Database.BatchableContext BC , List<lead> scope){
        
        Set<String> emailstring = new Set<String>();
		List<lead> duplicatelist = new List<lead>();
        system.debug('-----------'+scope);
        
        for(lead s : scope){
			if(!EmailBookmap.containsKey(s.Email)){
				EmailBookmap.put(s.Email, s);
			}
			else{
				duplicatelist.add(s);			
			}                        
        }  
        system.debug(duplicatelist);
		if(duplicatelist.size() > 0){
			delete duplicatelist;
		}
    } 
    global void finish(Database.BatchableContext BC){
        
    }
}