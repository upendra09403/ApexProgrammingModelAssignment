/*
  extension class for vfpage vf_servicefieldManagement to get the existing record
  through email then update record.
  date- 04/02/2021
  Upendra Singh
*/
public class Cont_FieldServiceToUpdate {
    public List<Customer_Service__c> searchResult{get;set;}
    public Customer_Service__c getStatus{get;set;}
    public string emailId{get;set;}
    public Cont_FieldServiceToUpdate(Cont_ServiceFieldManagement Controller) {
  searchResult=new list<Customer_Service__c>();
}
    public pagereference getRecord(){
        searchResult= [select Product_Name__c,Purchase_Date__c,Service_Required__c,Customer_Name__c,Phone__c,Email__c,
               Submission_Date__c,Address__c from Customer_Service__c where Email__c=:emailId];
        return null;
    }
    public pagereference Status(){
        getStatus=[select id,status__c,field_agent__r.name,field_agent__r.Phone__c from Customer_Service__c where id=:searchResult[0].id];
        return null;
    }
    public pagereference updateresult(){
        
            update searchResult;
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
    }
    public pagereference goBack(){
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
        
    }
}