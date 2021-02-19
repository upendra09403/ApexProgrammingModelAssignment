@RestResource(urlMapping='/account/*')
global class AccountManager {

    @HttpGet
    global static map<string,string> getAccount(){
        restrequest request=restcontext.request;
        string accid=request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        map<string,string> accountConDetail=new map<string,string>();
        account result=[select id,name,(select id,lastname from contacts) from account where id=:accid];
        accountConDetail.put(result.id,result.name);
        return accountConDetail;
    }    
}