@isTest
public class Test_ESPLBasicProgrammingSet2 {
 
    @isTest static void TestBasicProgram(){
        ESPLBasicProgrammingSet2 es=new ESPLBasicProgrammingSet2();
        boolean isPrime=es.CheckPrimeNo(5);
        system.assertEquals(true, isPrime);
        boolean isPrime1=es.CheckPrimeNo(4);
        system.assertEquals(false, isPrime1);
        //Palindrome
        system.assertEquals(true, es.CheckPalindrome(121));
        system.assertNotEquals(true, es.CheckPalindrome(1231));
        string str='salesforce';
        string st=es.ReplaceCharacter(str, 'b');
        system.assertEquals('sblesforce', st);
        //get string length
        system.assertEquals(10, es.getStringLength(str));
        
        //getting unique values
        integer[] intArray=new integer[]{2,3,5,2,6,8};
            set<integer>intSet=new set<integer>{2,3,5,6,8};
                system.assertEquals(intSet, es.uniqueValues(intArray));
    }
}