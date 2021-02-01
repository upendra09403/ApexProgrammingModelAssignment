global class SoapTest_AccountObj1 {

    webservice static id createAccount(string Name,string Rating){
        account acc=new account();
        acc.Name=Name;
        acc.Rating=Rating;
        insert acc;
        return acc.id;
    }
}