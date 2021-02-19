public class Controller_StudentForm {
     public student__c c { get; set; }
    public string selectedLang{get;set;}
    public List<selectoption> getAvailableLanguages(){
    
        List<selectOption> options = new List<selectOption>();
        options.add(new selectOption('en','English'));
        options.add(new selectOption('es','Spanish'));
        options.add(new selectOption('fr','French'));
        return options;
    }
    
    public Controller_StudentForm(){
       c=new student__c();
    }

    public PageReference save() {
        if (c.Name == null || c.Name == ''){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Student Name'));
     }
   if (c.Name != null && c.Name != ''){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Your admission application has been submitted successfully'));
   }
       insert c;  
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
    }
     public pagereference cancel(){
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
        
    }
}