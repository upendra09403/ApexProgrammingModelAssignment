trigger CampaignMemberTrigger on CampaignMember (before insert) {

 if(TriggerSetting__c.getInstance().CampaignMemberTrigger__c==false){
return;
}
 ECS11_ProgrammaticModel3Set3.campaignMember(trigger.new);
 
}