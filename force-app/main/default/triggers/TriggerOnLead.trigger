trigger TriggerOnLead on Lead (after insert,after update) {

if(TriggerSetting__c.getInstance().TriggerOnLead__c==false){
return;
}
/*
    if(trigger.isafter){
    if(CheckRecursive.runOnce()) {
    if(trigger.isInsert){
        ECS_11_ProgrammaticModel_3Set2.cloneLead(trigger.newMap);
    }
    }
    }
    */
   
}