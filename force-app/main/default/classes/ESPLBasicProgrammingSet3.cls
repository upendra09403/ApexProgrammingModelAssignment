public class ESPLBasicProgrammingSet3 {
    public integer FibonacciNumbers(integer n){
        integer a=0;
        integer b=1;
        integer c;
        for(integer i=0;i<n;i++){
            system.debug(a+' ');
            c=a+b;
            a=b;
            b=c;
        }
        return a;
    }
   
    public string ReverseString(string str){
        system.debug('Reverse string is '+str.reverse());
        return str.reverse();
    }
    public string[] OperationMethod(string str){
        string replaceOcc=str.replace('@', 'A');
        system.debug('Replace occurance of @ with A :'+replaceOcc);
        system.debug('Substring is :'+replaceOcc.substring(11));
        system.debug('Split the string using speces :'+str.split(' '));
        string[] str1=str.split(' ');
        for(integer i=0;i<str1.size();i++){
            system.debug('Result after split is :'+str1[i]);
        } 
        system.debug('After Removing white spaces :'+str.deleteWhitespace());
        system.debug('String to upper case :'+str.toUpperCase());
        system.debug('String to Lower case :'+str.toLowerCase());  
        return str1;
    }
    public list<string> getStringOccurence(string str){
        string strArray=str.deleteWhitespace();
        string[] stringArray=strArray.split('');
        //system.debug(stringArray);
        set<string>strSet=new set<string>();
        for(string st:stringArray){
            strSet.add(st);
        }
        //system.debug(strSet);
        list<string>strlist=new list<string>();
        for(string s:strSet){
            strlist.add(s);
        }
        for(integer i=0;i<strSet.size();i++){
            system.debug('String character occures '+strlist[i]+' :='+str.countMatches(strlist[i])+' Times');
        }
        system.debug(strlist);
        return strlist;
    } 
    
    // calling static method from opps concept set3 to non static method
    
    public void CallMethod(){
        OOPSConceptsSet3.callFromNonStatic();
    }
}