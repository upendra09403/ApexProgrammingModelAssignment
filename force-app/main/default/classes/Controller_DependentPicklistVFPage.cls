public class Controller_DependentPicklistVFPage {
 
    public string Country{get;set;}
    public string City{get;set;}
    public List<system.SelectOption> getCountryOptions{get;set;}
    public List<system.SelectOption> cityOptions{get;set;}
    //public Controller_DependentPicklistVFPage(ApexPages.StandardController controller){}
    public Controller_DependentPicklistVFPage(){
      getCountryOptions=new List<system.SelectOption>();
        getCountryOptions.add(new system.SelectOption('Select One','Select One'));
        for (Country__c iso :Country__c.getAll().values()){
        getCountryOptions.add(new system.SelectOption(iso.Name,iso.name));
        }
    }
    public PageReference  getCityOptions(){
        cityOptions=new list<system.SelectOption>();
        cityOptions.add(new system.SelectOption('--None--','--None--'));
        list<city__c> cities=[select name from city__c where country__c=:country];
        for (city__c ct :Cities){
        cityOptions.add(new system.SelectOption(ct.Name,ct.name));
        }
        return null;
    }
}