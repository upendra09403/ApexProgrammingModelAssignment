public class ESPLBasicProgrammingSet2 {
    
    public boolean CheckPrimeNo(integer n){
        boolean isPrime=true;
        for(integer i=2;i<n;i++){
            if(math.mod(n,i)==0){
                isPrime=false;
                break;
            }
        }
        if(isPrime==true && n!=1){
            system.debug('This is a prime number');
        }else{
            system.debug('This is not a prime number');
        }
        return isPrime;
    }
    public boolean CheckPalindrome(integer n){
        boolean isPalindrome;
        integer reverse=0;
        integer temp=n;
        while(n>0){
            reverse=reverse*10;
            reverse=reverse + math.mod(n,10);
            n=n/10;
        }
        if(reverse==temp){
            system.debug('Number is palindrome Number');
            isPalindrome=true;
        }else{
            system.debug('Number is not palindrome Number');
            isPalindrome=false;
        }
        return isPalindrome;
    }
    public string ReplaceCharacter(string Arraystr,string str){
        
        system.debug(Arraystr.replace('a',str));
        return Arraystr.replace('a',str);
    }
    // question 4 *******
    public integer getStringLength(string str){
        list<string>st=str.split('');
        system.debug('Length of string is :'+st.size());
        return st.size();
    }
    
    public set<integer> uniqueValues(integer[] nums){
        set<integer>uniqueList=new set<integer>();
        for(integer i:nums){
            uniqueList.add(i);
        }
        system.debug('Unique numbers are '+uniqueList);
        return uniqueList;
    }  
}