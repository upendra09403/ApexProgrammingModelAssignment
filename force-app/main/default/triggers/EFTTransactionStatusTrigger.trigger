trigger EFTTransactionStatusTrigger on EFT_Transaction_Status__c (after insert) {

if(TriggerSetting__c.getInstance().EFTTransactionStatusTrigger__c==false){
return;
}
    if(trigger.isafter && trigger.isinsert){
        ECS11Model3Set1.EFTTransactionStatusInsert(trigger.newMap);
    }
}