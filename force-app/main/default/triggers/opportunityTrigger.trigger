trigger opportunityTrigger on Opportunity (after insert) {

if(TriggerSetting__c.getInstance().opportunityTrigger__c==false){
return;
}
/*
    if(trigger.isafter){
    if(CheckRecursive.runOnce()) {
    if(trigger.isInsert){
        ECS11_ProgrammaticModel3Set3.cloneOpportunity(trigger.newMap);
    }
    }
    }
*/
}