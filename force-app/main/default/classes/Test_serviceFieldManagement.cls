@istest
public class Test_serviceFieldManagement {

    @istest static void customerServiceInsertTest(){
        Customer_Service__c cust=new Customer_Service__c();
        cust.Product_Name__c='ProductName';
        date d=date.newInstance(2020, 01, 01);
        cust.Purchase_Date__c=d;
        cust.Service_Required__c='serviceNeeded';
        cust.Customer_Name__c='customerName';
        cust.Phone__c='12321232';
        cust.Email__c='cust@gmail.com';
        cust.Submission_Date__c=date.today();
        cust.City__c='Pune';
        cust.Address__c='address';
        insert cust;
        
        // insert field agent***
        field_agent__c fa=new field_agent__c();
        fa.name='Field Agent';
        fa.Email__c='agent@gmail.com';
        fa.Phone__c='123654123';
        fa.City__c='Pune';
        fa.Street__c='604/21 om nagar';
        fa.State__c='Maharashtra';
        fa.Postal_Code__c=144007;
        insert fa;
        list<Customer_Service__c> workOrder=[select id,Product_Name__c,Customer_Name__c,city__c,field_agent__c from Customer_Service__c where city__c=:cust.city__c and field_agent__c=null];
        
      list<field_agent__c>  agent=[select id,name,phone__c,email__c,city__c from field_agent__c where city__c=:fa.City__c];
       list<string> sendingTo=new list<string>();
        sendingTo.add(fa.Email__c);
        for(Customer_Service__c cs:workOrder){
            cs.Field_Agent__c=fa.id;
            cs.Status__c='Assigned';
            update cs;
        }
        
        // sending email to field agent after assignment   
        
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        semail.setToAddresses(sendingTo);
        semail.setSubject('New Work Order Assigned To You!!!');
        semail.setPlainTextBody('Hello!!!!! You have been assigned to new work orders');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});  
        
        Test.StartTest(); 

			PageReference pageRef = Page.VF_ServiceFieldManagement; // Add your VF page Name here
       
			Test.setCurrentPage(pageRef);   
        Cont_ServiceFieldManagement testWorkPlan = new Cont_ServiceFieldManagement();
        testWorkPlan.ProductName=cust.Product_Name__c;
        testWorkPlan.PurchaseDate=cust.Purchase_Date__c;
        testWorkPlan.serviceNeeded=cust.Service_Required__c;
        testWorkPlan.customerName=cust.Customer_Name__c;
        testWorkPlan.Phone=cust.Phone__c;
        testWorkPlan.email=cust.email__c;
        testWorkPlan.city=cust.city__c;
        testWorkPlan.address=cust.address__c;
        testWorkPlan.agentCity=fa.city__c;
			testWorkPlan.save();
        testWorkPlan.cancel();
        testWorkPlan.getorders();
        testWorkPlan.getAgent();
        testWorkPlan.AssignAgent();
        testWorkPlan.sendEmail();
       /*     Cont_FieldServiceToUpdate extupdate=new Cont_FieldServiceToUpdate(testWorkPlan);
        extupdate.getRecord();
        extupdate.Status();
        extupdate.updateresult();
        extupdate.goBack();
			*/
		Test.StopTest();
    }
    @istest static void extcontrollrTest(){
         // insert field agent***
        field_agent__c fa=new field_agent__c();
        fa.name='Field Agent';
        fa.Email__c='agent@gmail.com';
        fa.Phone__c='123654123';
        fa.City__c='Pune';
        fa.Street__c='604/21 om nagar';
        fa.State__c='Maharashtra';
        fa.Postal_Code__c=144007;
        insert fa; 
        Customer_Service__c cust=new Customer_Service__c();
        cust.Product_Name__c='ProductName';
        date d=date.newInstance(2020, 01, 01);
        cust.Purchase_Date__c=d;
        cust.Service_Required__c='serviceNeeded';
        cust.Customer_Name__c='customerName';
        cust.Phone__c='12321232';
        cust.Email__c='cust@gmail.com';
        cust.Submission_Date__c=date.today();
        cust.City__c='Pune';
        cust.Address__c='address';
        cust.Field_Agent__c=fa.Id;
        insert cust;
        
      List<Customer_Service__c>  searchResult= [select Product_Name__c,Purchase_Date__c,Service_Required__c,Customer_Name__c,Phone__c,Email__c,
               Submission_Date__c,Address__c from Customer_Service__c where Email__c=:cust.Email__c];
      Customer_Service__c  getStatus=[select id,status__c,field_agent__r.name,field_agent__r.Phone__c from Customer_Service__c where id=:searchResult[0].id];
       Test.StartTest(); 

			PageReference pageRef = Page.VF_ServiceFieldManagement; 
       
			Test.setCurrentPage(pageRef);
        Cont_ServiceFieldManagement testWorkPlan = new Cont_ServiceFieldManagement();
        Cont_FieldServiceToUpdate extupdate=new Cont_FieldServiceToUpdate(testWorkPlan);
        extupdate.emailId=string.valueof(cust.Email__c);
        extupdate.getRecord();
        extupdate.Status();
        extupdate.updateresult();
        extupdate.goBack();
        test.stopTest();
    }
}