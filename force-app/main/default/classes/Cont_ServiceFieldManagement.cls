/*
controller class for vfpage vf_servicefieldManagement where customer can submit their form 
as per the field service requirement
date- 04/02/2021
Upendra Singh
*/

public class Cont_ServiceFieldManagement {
    list<String> sendingTo =new list<string>();
    list<id> idListAgent=new list<id>();
    set<id> idsetCustomer=new set<id>();
    public string agentId{get;set;}
    public list<field_Agent__c> agent{get;set;}
    public string agentCity {get;set;}
    public list<Customer_Service__c> orders{get;set;}
    public Customer_Service__c customer{get;set;}
    public string ProductName{get;set;}
    public date PurchaseDate{get;set;}
    public string serviceNeeded{get;set;}
    public string customerName{get;set;}
    public string phone{get;set;}
    public string email{get;set;}
    public string city{get;set;}
    public string address{get;set;}
    
    public Cont_ServiceFieldManagement(){
        
    }
    public pagereference save(){
        Customer_Service__c cust=new Customer_Service__c();
        cust.Product_Name__c=ProductName;
        cust.Purchase_Date__c=PurchaseDate;
        cust.Service_Required__c=serviceNeeded;
        cust.Customer_Name__c=customerName;
        cust.Phone__c=phone;
        cust.Email__c=email;
        cust.Submission_Date__c=date.today();
        cust.City__c=city;
        cust.Address__c=address;
        insert cust;
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
    }
    public pagereference cancel(){
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
        
    }
    public pagereference getorders(){
        orders=[select id,Product_Name__c,Customer_Name__c,city__c,field_agent__c from Customer_Service__c where city__c=:agentCity and field_agent__c=null];
        for(Customer_Service__c cust:orders){
            idsetCustomer.add(cust.id);
            
        }
        return null;
    }
    public pagereference getAgent(){
        agent=[select id,name,phone__c,email__c,city__c from field_agent__c where city__c=:agentCity] ;
        for(field_agent__c ag:agent){
            idListAgent.add(ag.id);
            sendingTo.add(ag.email__c);
        }
        return null;
    }
    public pagereference AssignAgent(){
        list<Customer_Service__c> custList=new list<Customer_Service__c>();
        list<Customer_Service__c> customerList=[select id,Product_Name__c,field_agent__c,status__c from Customer_Service__c where id in:idsetCustomer];
        for(Customer_Service__c cust:customerList){
            cust.Field_Agent__c=idListAgent[0];
            cust.status__c='Assigned';
            custList.add(cust);  
        }
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        semail.setToAddresses(sendingTo);
        semail.setSubject('New Work Order Assigned To You!!!');
        semail.setPlainTextBody('Hello!!!!! You have been assigned to new work orders');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        update custList;
        return null;
    }
   
    
    /*public pagereference GetMap(){
agent=[select id,name,city__c,state__c,street__c,postal_code__c,(select id,Customer_Name__c,city__c,Address__c from customer_services__r where status__c='Assigned')from field_agent__c];

return null;

}  */
}