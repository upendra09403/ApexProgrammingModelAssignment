trigger SalesHeaderTrigger on SalesHeader__c (after insert,after update) {

if(TriggerSetting__c.getInstance().SalesHeaderTrigger__c==false){
return;
}

    if(trigger.isafter){
        if(trigger.isinsert||trigger.isupdate){
            ECS11_ProgrammaticModel3Set3.BillingToShipping(trigger.new);
        }
    }
}