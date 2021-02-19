@istest
public class Test_ServiceCompletedTrig {
    @istest static void completedWorkOrdertest(){
        Customer_Service__c cust=new Customer_Service__c();
        cust.Product_Name__c='ProductName';
        date d=date.newInstance(2020, 01, 01);
        cust.Purchase_Date__c=d;
        cust.Service_Required__c='serviceNeeded';
        cust.Customer_Name__c='customerName';
        cust.Phone__c='12321232';
        cust.Email__c='cust@gmail.com';
        cust.Status__c='New';
        cust.Submission_Date__c=date.today();
        cust.City__c='Pune';
        cust.Address__c='address';
        insert cust;
        customer_service__c CustomerList=[select id,customer_name__c, Service_Charge__c,Email__c,status__c from customer_service__c where id =:cust.id];
       list<string> sendingTo=new list<string>();
        sendingTo.add(CustomerList.Email__c);
        CustomerList.Status__c='Completed';
        update CustomerList;
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        semail.setToAddresses(sendingTo);
        semail.setSubject('Service Request is completed successfullly');
        semail.setPlainTextBody('Hello!!!!! '+CustomerList.customer_name__c+' Your service request has been completed successfully. The service charge is- '+CustomerList.Service_Charge__c);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
    }
}