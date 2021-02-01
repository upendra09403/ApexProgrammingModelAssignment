@isTest
private class Test_ESPLBasicProgrammingSet3 {

    @istest static void basicProgrammingTest(){
        
        ESPLBasicProgrammingSet3 es=new ESPLBasicProgrammingSet3();
        //FibonacciNumbers
            system.assertEquals(2, es.FibonacciNumbers(3));
        
        string str='welcome';
        system.assertEquals('emoclew', es.ReverseString(str));
        
        string str1='upendra@gmail';
        string replace=str1.replace('@', 'A');
        string[] splitResult=str1.split(' ');
        system.assertEquals(splitResult, es.OperationMethod(str1));
        
        string s1='welcome';
        list<string>stList=new list<string>{'w','e','l','c','o','m'};
        system.assertEquals(stList, es.getStringOccurence(s1));
    }
}