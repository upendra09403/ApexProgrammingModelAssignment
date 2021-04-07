/* Requirement-Need to fetch the listview id based on sobject type and listview name
 * which are passed by the component controller.
 * based on listview id and sobject type I need to get all listview records for a particular 
 * listview
 * Name-Upendra Singh
 * Date- 15-02-2021
 * version=1
 */
public class ListviewResultClass {
    
   public static String fetchUserSessionId(){
        String sessionId = '';
        // Refer to the Page
        try{
        PageReference reportPage = Page.getSessionId;
        // Get the content of the VF page
        String vfContent = reportPage.getContent().toString();
        System.debug('vfContent '+vfContent);
        // Find the position of Start_Of_Session_Id and End_Of_Session_Id
        Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
            endP = vfContent.indexOf('End_Of_Session_Id');
        // Get the Session Id
        sessionId = vfContent.substring(startP, endP);
        System.debug('sessionId '+sessionId);
        }catch(VisualforceException e){
            sessionId = String.valueOf('Some Text');
        }
        // Return Session Id
        return sessionId;
    }
    
    @AuraEnabled
    public static list<listview> getListViews(string obj){
        list<listview> allListViews=[select Name from listview where sobjectType=:obj];
        system.debug(allListViews);
        return allListViews;
    }
    @AuraEnabled
    public static ListViewDescribeResult getListViewdescribe(string obj,string listView_Name) {
        String sessionId = ListviewResultClass.fetchUserSessionId();
        ListView listViewResult = [select id, developername,sobjectType  from listview where sobjectType=:obj AND Name=:listView_Name];
        system.debug(listViewResult);
        String endpoint = String.format(
            'https://proseraa5-dev-ed.my.salesforce.com/services/data/v51.0/sobjects/{0}/listviews/{1}/describe/',
            new String[] { listViewResult.sobjectType, listViewResult.id }
        );  
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint( endpoint );
        req.setMethod( 'GET' );
        req.setHeader( 'Content-Type', 'application/json' );
        req.setHeader( 'Accepts', 'application/json' );
        req.setHeader('Authorization', 'Bearer '+sessionId);
        HttpResponse res = new Http().send( req );
        System.debug( res);
        System.debug( res.getBody() );
        
        ListViewDescribeResult result = (ListViewDescribeResult)JSON.deserialize(res.getBody(),ListViewDescribeResult.class);
        system.debug('query :'+result.query);
        system.debug('deserialized result :'+result);
        return result;
    }
        @AuraEnabled
        public static ListViewDataTable getListViewData(string obj,string listView_Name){
            ListViewDescribeResult result=new ListViewDescribeResult();
             result = ListviewResultClass.getListViewdescribe(obj,listView_Name );
       // ApexPages.StandardSetController controller = new ApexPages.StandardSetController( Database.getQueryLocator( result.query));
        ListViewDataTable dataTable = new ListViewDataTable();
        dataTable.describeResult = result;
            if(result.query!=null){   
        dataTable.records = database.query(result.query);
            }
        system.debug('record List===== :'+dataTable.records);
        return dataTable;  
    }
    @AuraEnabled
    public static list<sobject> fetchRecordsByName(string searchStr,string obj){
        list<sobject>returnRecord=new list<sobject>();
        string name='%'+searchStr+'%';
        if(obj=='Account'){
        returnRecord= [select id,Name,BillingState,Phone,type,Rating,Industry from Account where Name like :name];
            system.debug(returnRecord);
            return returnRecord;
        }else if(obj=='Contact'){
            returnRecord= [select id,Name,Phone,email from contact where Name like :name];
            system.debug(returnRecord);
            return returnRecord;
        }else if(obj=='Lead'){
            returnRecord= [select id,Name,company,email,status from Lead where Name like :name];
            system.debug(returnRecord);
            return returnRecord;
        }else if(obj=='Opportunity'){
            returnRecord= [select id,Name,amount,closedate,stagename from Opportunity where Name like :name];
            system.debug(returnRecord);
            return returnRecord;
        }
        return null;
    }
    @AuraEnabled
    public static boolean updateRecord(List<sobject> editedList ){
        try {  
            
            update editedList;  
            return true;  
            
        } catch(Exception e) {  
            
            return false;  
            
        }
    }
    
    public class ListViewDataTable {
        
        @AuraEnabled
        public List<sObject> records { get; set; }
        
        @AuraEnabled
        public ListViewDescribeResult describeResult { get; set; }
        
    }
    public class ListViewDescribeResult {
        
        @AuraEnabled
        public ID id { get; set; }
        
        @AuraEnabled
        public String query { get; set; }
        
        @AuraEnabled
        public String sobjectType { get; set; }
        
        @AuraEnabled
        public List<Map<String, String>> columns { get; set; }
        
        
    }   
    
}