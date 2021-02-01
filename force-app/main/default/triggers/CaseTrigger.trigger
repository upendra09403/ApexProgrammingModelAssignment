trigger CaseTrigger on Case (before insert) {
  if(TriggerSetting__c.getInstance().CaseTrigger__c==false){
return;
}

    if(trigger.isbefore && trigger.isinsert){
    ECS_11_ProgrammaticModel_3Set2.EmailCheckCase(trigger.new);
    }
}