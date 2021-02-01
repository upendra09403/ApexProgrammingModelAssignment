public class Batch_ClosedWonOpp implements Database.Batchable<sObject>,Database.Stateful{
    string query;
    Map<String,List<Opportunity>> contactOpprtunitiesMap =new Map<String,List<Opportunity>>();
    public database.QueryLocator start(Database.BatchableContext BC){
        query='select name ,(select email from contacts where primeryContact__c=true limit 1),(select name,amount from opportunities where iswon=true) from account where id in (select accountid from contact where primerycontact__c=true) and id in(select accountid from opportunity)';
        return database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC,list<sobject>scope){
        List<Account> accountList = (List<Account>) scope;
        System.debug(scope + '------------------------- ');
        for(Account acc : accountList) {
            if(acc.Contacts[0].email != null) {
                contactOpprtunitiesMap.put(acc.Contacts[0].email,acc.Opportunities);
            }
        }
    }
    public void finish(Database.BatchableContext BC){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for( String mailId : contactOpprtunitiesMap.keySet() ) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add(mailId);
            mail.setToAddresses(sendTo);
            mail.setReplyTo('upendra09403@gmail.com');
            mail.setSubject('All Closed Won Opportunities');
            String body = '<html><body>Dear Sir/Mam, <br/><br/>';
            body += 'All Closed Won Opportunities are - <br/>';
            Decimal total = 0;
            for( Opportunity opportunityRecord : contactOpprtunitiesMap.get(mailId) ) {
                body += '&nbsp;&nbsp;&nbsp;&nbsp;' + opportunityRecord.Name + ': ' +
                    opportunityRecord.Amount + '<br/>';
                total += opportunityRecord.Amount;
            }
            body += '<br/>&nbsp;&nbsp;&nbsp;&nbsp; <b>Total: ' + total + '</b></body></html>';
            mail.setHtmlBody(body);
            System.debug(body);
            mails.add(mail);
        }
        Messaging.sendEmail(mails);
    }
}