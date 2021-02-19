trigger ServiceCompletedTrig on Customer_Service__c (after update) {
    set<id>AccIdset=new set<id>();
    for(Customer_Service__c cust:trigger.new){
        if(cust.Status__c=='Completed' && cust.Status__c!= trigger.oldmap.get(cust.id).status__c){
            AccIdset.add(cust.id);
        }
    }
    list<customer_service__c> CustomerList=[select id,customer_name__c, Service_Charge__c,Email__c from customer_service__c where id in:AccIdset];
    list<string> sendingTo=new list<string>();
    for(customer_service__c cs:trigger.new){
        for(customer_service__c cstm:CustomerList){
            sendingTo.add(cstm.email__c);
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        semail.setToAddresses(sendingTo);
        semail.setSubject('Service Request is completed successfullly');
        semail.setPlainTextBody('Hello!!!!! '+cstm.Customer_Name__c+' Your service request has been completed successfully. The service charge is- '+cstm.Service_Charge__c);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        }
    }
}