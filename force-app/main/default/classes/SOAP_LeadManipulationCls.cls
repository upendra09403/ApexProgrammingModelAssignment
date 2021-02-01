global class SOAP_LeadManipulationCls {
    
    webservice static id createLead(string Fname,string Lname,string Email,string phn){
        //list<lead>leads=new list<lead>();
        lead led=new lead();
        led.FirstName=Fname;
        led.LastName=Lname;
        led.Email=Email;
        led.Phone=phn;
        led.Company='Salesforce';
        Database.SaveResult result=database.insert(led,false);
        if(result.isSuccess()){
            System.debug('Successfully inserted account. Account ID: ' + result.getId());
        }else{
            for(database.Error err:result.geterrors()){
                System.debug('The following error has occurred.');
               System.debug(err.getStatusCode() + ': ' + err.getMessage()); 
            }
        }
        return result.id;
    }
    webservice static string DeleteLead(string Fname,string Lname,string Email,string phn){
        list<lead> result=[select id, firstname,lastname from lead where firstname=:Fname and lastname=:Lname and Email=:Email and Phone=:phn];
        if(result.size()>0){
            database.DeleteResult[] drList=Database.delete(result, false);
        
        for(Database.DeleteResult dr : drList) {
    if (dr.isSuccess()) {
        System.debug('Successfully deleted account with ID: '+ dr.getId());
    }else{
        for(Database.Error err : dr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
        }
    }
    }
        }
            return Fname+' '+Lname;
        }
    webservice static id UpdateLead(string Fname,string Lname,string NewEmail,string Newphn){
       list<lead> result=[select id,firstname,lastname,Email,Phone from lead where Firstname=:Fname and lastName=:Lname];
        list<lead>updatedLead=new list<lead>();
        if(result.size()>0){
            for(lead led:result){
                led.Email=NewEmail;
                led.Phone=Newphn;
                updatedLead.add(led);
            }
            Database.SaveResult[] srList=Database.update(updatedLead,false);
            for(database.SaveResult sr:srList){
                if(sr.isSuccess()){
                System.debug('Successfully updated account. Account ID: ' + sr.getId());
        }else{
            for(database.Error err:sr.geterrors()){
                System.debug('The following error has occurred.');
               System.debug(err.getStatusCode() + ': ' + err.getMessage()); 
            }
            }
            }
            
        }
        return result[0].id;
    }
}