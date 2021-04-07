/* Requirement- The requirement is to integrate two different salesforce org If I create a contact
 * in source org it should be automatically created in destination org with last name.
 * Name-Upendra Singh
*  Date- 15-02-2021
*  Version=1
*/

public class ContactCreationDestinationClass {
    
    ConnectedAppCred__mdt cred=[select ClientId__c,ClientSecret__c,Password__c,UserName__c from ConnectedAppCred__mdt where label like 'Destin%'];
    
    String clientId =cred.ClientId__c;
    String clientsecret=cred.ClientSecret__c;
    String username=cred.UserName__c ;
    String password=cred.Password__c;
    
    //Wrapper class to store the response
    public class ConWrapper { 
        public String access_token;
        Public string token_type;
        public string instance_url;
    }
    public String ReturnAccessToken(){ 
        String requestbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientsecret+'&username='+username+'&password='+password;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(requestbody);
        req.setMethod('POST'); 
        req.setEndpoint('https://destination2-dev-ed.my.salesforce.com/services/oauth2/token'); 
        HttpResponse res=h.send(req);  
        System.debug('Response Body : '+res.getBody());
        ConWrapper result= (ConWrapper)JSON.deserialize(res.getBody(),ConWrapper.class);
        System.debug('Response After Deserialization :'+result);
        system.debug('Access_token :' +result.access_token);
        system.debug('token_type :' +result.token_type);
        system.debug('instance_url :' +result.instance_url);
        return result.access_token; 
    }
    @future(callout=true)
    public static void createContactRecord(String LastName){   
        ContactCreationDestinationClass con= new ContactCreationDestinationClass(); 
        String accessToken=con.ReturnAccessToken();
        System.debug(' Access Token :'+accessToken);
        if(accessToken!=null){
            String jsonstring='{"LastName":"'+ LastName +'"}';
            Http h2= new Http();
            HttpRequest newreq= new HttpRequest();
            newreq.setHeader('Authorization','Bearer ' + accessToken);
            newreq.setHeader('Content-Type','application/json');
            newreq.setBody(jsonstring);
            newreq.setMethod('POST');
            newreq.setEndpoint('https://destination2-dev-ed.my.salesforce.com/services/apexrest/CreateContact/');
                HttpResponse response=h2.send(newreq);
                system.debug('Response body :'+response.getBody());
                system.debug('Response Status :'+response.getStatus());
                system.debug('Response Status Code :'+response.getStatusCode());
                ConWrapper DeserializedResult=(ConWrapper)JSON.deserialize(newreq.getBody(),ConWrapper.class);
                system.debug('Deserialized body :'+DeserializedResult);     
        }   
    }  
}