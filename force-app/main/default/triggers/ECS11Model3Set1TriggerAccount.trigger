trigger ECS11Model3Set1TriggerAccount on Account (before insert,before update,after insert) {
    
    if(TriggerSetting__c.getInstance().ECS11Model3Set1TriggerAccount__c==false){
    return;
    }
    /*if(trigger.isInsert){
        ECS11Model3Set1.checkDebugAccount(trigger.new);
        system.debug('Trigger is fired due to insertion');
    }
    if(trigger.isupdate){
     ECS11Model3Set1.checkDebugAccount(trigger.new);   
    ECS11Model3Set1.checkDebugAccount(trigger.old);
        ECS11Model3Set1.checkDebugAccountForMap(trigger.newMap);
        ECS11Model3Set1.checkDebugAccountForMap(trigger.oldMap);
     system.debug('Trigger is fired due to Updation');  
    }  */
    
    // calling method for cloning account using after trigger****
    /*
    if(trigger.isafter){
    if(CheckRecursive.runOnce()) {
    if(trigger.isInsert){
        ECS11Model3Set1.cloneAccount(trigger.newMap);
    }
    }
    }   */
    
    if(trigger.isafter && Trigger.isinsert){
        ECS_11_ProgrammaticModel_3Set2.TaskCreationAfterAccountInsert(trigger.newmap);
    }
}