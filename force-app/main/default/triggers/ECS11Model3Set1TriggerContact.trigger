trigger ECS11Model3Set1TriggerContact on Contact (before insert,before update,before delete,after insert,after update,after delete,after undelete) {
   
   if(TriggerSetting__c.getInstance().ECS11Model3Set1TriggerContact__c==false){
    return;
    }
   
    /* For Second question in ECSModel3Set1
    if(trigger.isbefore){
        if(trigger.isInsert){
            ECS11Model3Set1.checkDebugContact(trigger.new);
            system.debug('Trigger is fired due to before trigger insertion');
        }
        if(trigger.isUpdate){
            ECS11Model3Set1.checkDebugContact(trigger.new);
            ECS11Model3Set1.checkDebugContactForMap(trigger.newMap);
            ECS11Model3Set1.checkDebugContact(trigger.old);
            ECS11Model3Set1.checkDebugContactForMap(trigger.oldMap);
            system.debug('Trigger is fired due to before trigger updation'); 
        }
        if(trigger.isdelete){
            ECS11Model3Set1.checkDebugContact(trigger.old);
            ECS11Model3Set1.checkDebugContactForMap(trigger.oldMap);
            system.debug('Trigger is fired due to before trigger Deletion');
        }
        
    }
    //for after event*********
    if(trigger.isafter){
        if(trigger.isinsert){
           ECS11Model3Set1.checkDebugContact(trigger.new);
            ECS11Model3Set1.checkDebugContactForMap(trigger.newMap);
            system.debug('Trigger is fired due to after trigger insertion');
        }
        if(trigger.isupdate){
          ECS11Model3Set1.checkDebugContact(trigger.new);
            ECS11Model3Set1.checkDebugContactForMap(trigger.newMap);
            ECS11Model3Set1.checkDebugContact(trigger.old);
            ECS11Model3Set1.checkDebugContactForMap(trigger.oldMap);
            system.debug('Trigger is fired due to after trigger updation');  
        }
        if(trigger.isdelete){
            ECS11Model3Set1.checkDebugContact(trigger.old);
            ECS11Model3Set1.checkDebugContactForMap(trigger.oldMap);
            system.debug('Trigger is fired due to after trigger Deletion'); 
        }
        if(trigger.isundelete){
            ECS11Model3Set1.checkDebugContact(trigger.new);
            ECS11Model3Set1.checkDebugContactForMap(trigger.newMap);
            system.debug('Trigger is fired due to after trigger UnDeletion');
        }
    }   */
    
    
   /* if(trigger.isbefore && trigger.isinsert){
        ECS11Model3Set1.preventDuplicateContact(trigger.new);
    }
    */
}