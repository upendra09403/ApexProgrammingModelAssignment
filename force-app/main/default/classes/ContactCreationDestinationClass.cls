public class ContactCreationDestinationClass {
    
    ConnectedAppCred__mdt cred=[select label,ClientId__c,ClientSecret__c,Password__c,UserName__c from ConnectedAppCred__mdt];
     
    String clientId =cred.ClientId__c;
    String clientsecret=cred.ClientSecret__c;
    String username=cred.UserName__c ;
    String password=cred.Password__c+'LF583gCG9CpFKK33csvXjmjzu';
    
    public class ConWrapper { 
        public String access_token; 
    }
       public String ReturnAccessToken(ContactCreationDestinationClass con){ 
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientsecret+'&username='+username+'&password='+password;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST'); 
        req.setEndpoint('https://destination2-dev-ed.my.salesforce.com/services/oauth2/token'); 
        HttpResponse res=h.send(req);  
        System.debug(res.getBody()+' ########Response');
        ConWrapper resp1= (ConWrapper)JSON.deserialize(res.getBody(),ConWrapper.class);
        System.debug(resp1+' #######deserializeresponse');
        system.debug('###access_token####' +resp1.access_token);
        return resp1.access_token; 
    }
    @future(callout=true)
    public static void createContactRecord(String LastName){   
        ContactCreationDestinationClass con= new ContactCreationDestinationClass(); 
        String accessToken=con.ReturnAccessToken(con);
        System.debug(accessToken+' #######AccessToken');
        if(accessToken!=null){
            String endPoint='https://destination2-dev-ed.my.salesforce.com/services/apexrest/CreateContact/';
            String jsonstr='{"LastName":"'+ LastName +'"}';
            Http h2= new Http();
            HttpRequest newreq= new HttpRequest();
            newreq.setHeader('Authorization','Bearer ' + accessToken);
            newreq.setHeader('Content-Type','application/json');
            newreq.setHeader('accept','application/json');
            newreq.setBody(jsonstr);
            newreq.setMethod('POST');
            newreq.setEndpoint(endPoint);
            HttpResponse res2=h2.send(newreq);
            system.debug('###Response body### '+res2.getBody());
            system.debug('###Response Status### '+res2.getStatus());
            system.debug('###Response Status Code### '+res2.getStatusCode());
            ConWrapper deresp=(ConWrapper)System.JSON.deserialize(newreq.getBody(),ConWrapper.class);
            system.debug('##Deserialized body### '+deresp);
        }
        
    } 
       
}