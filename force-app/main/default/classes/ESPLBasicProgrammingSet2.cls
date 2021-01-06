public class ESPLBasicProgrammingSet2 {
    
    public void CheckPrimeNo(integer n){
        boolean isPrime=true;
        for(integer i=2;i<n;i++){
            if(math.mod(n,i)==0){
                isPrime=false;
                break;
            }
        }
        if(isPrime==true){
            system.debug('This is a prime number');
        }else{
            system.debug('This is not a prime number');
        }
    }
    public void CheckPalindrome(integer n){
        integer reverse=0;
        integer temp=n;
        while(n>0){
            reverse=reverse*10;
            reverse=reverse + math.mod(n,10);
            n=n/10;
        }
        if(reverse==temp){
            system.debug('Number is palindrome Number');
        }else{
            system.debug('Number is not palindrome Number');
        }
    }
    public void ReplaceCharacter(string Arraystr,string str){
        
        system.debug(Arraystr.replace('a',str));
    }
    // question 4 *******
    
    public void uniqueValues(integer[] nums){
        set<integer>uniqueList=new set<integer>();
        for(integer i:nums){
            uniqueList.add(i);
        }
        system.debug('Unique numbers are '+uniqueList);
    }  
}