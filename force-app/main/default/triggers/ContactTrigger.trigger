trigger ContactTrigger on Contact (before insert,before update) {

if(TriggerSetting__c.getInstance().ContactTrigger__c==false){
    return;
    }
    if(trigger.isbefore){
        if(trigger.isinsert||trigger.isupdate){
            ECS12_ApexImplementation.makePrimeryContact(trigger.new);
        }
        
    if(trigger.isInsert){
        ECS12_ApexImplementation.ContactAccountAssociation(trigger.new);
    }
    }
}