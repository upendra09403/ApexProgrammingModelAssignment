public class ESPLProgrammaticModel1Class {
    
    public void numberCheck(integer A){
        if(math.mod(A,2)==0){
            system.debug('The number is an Even number');
        }
        else if(math.mod(A,2)!=0){
            system.debug('The number is an Odd number');
        }
    }
    public void numberCheck1(integer a){
        
        if((a/2)*2==a){
          system.debug('The number is an Even number');  
        }
        else if((a/2)!=a){
            system.debug('The number is an Odd number');
        }
    }
    
    
    // Ques 2 *******************
    public void PrintArray(integer X){
        for(integer i=1;i<=X;i++){
            system.debug('Welcome to Salesforce!!!');
        }
    }
    
    // Question 3 ***********************
    public void SortAscending(integer[] nums){
        nums.sort();
        system.debug('Ascending order is '+nums);
        integer[] A=new list<integer>();
        for(integer i=nums.size()-1;i>=0;i--){
            A.add(nums.get(i));
        }
        system.debug('Numbers in Descending orders are '+A);
    }
    
    public integer FindMinValue(integer[] nums){
   	 integer min;    
   	   
   	 min = nums[0];   
    
   	 for (integer i = 1 ; i < nums.size() ; i++ )
   	 {
   	    if ( nums[i] < min )
   	    {
   	      min = nums[i]; 
   	    }
   	 }
       system.debug('Minimum number is '+min);
   	 return(min); 
    }
    public integer FindMaxValue(integer[] nums){
      integer max=nums[0];
        for(integer i=1;i<nums.size();i++){
            if(nums[i]>max){
                max=nums[i];
            }
        }
        system.debug('Maximum number is '+max);
        return max;
    }
    
    public void findDuplicate(integer[] nums){
        for(integer i=0;i<nums.size();i++){
            for(integer j=i+1;j<nums.size();j++){
                if(nums[i]==nums[j]){
                    system.debug('The number '+nums[i]+' is a duplicate number');
                }
            }
        }
    }
   
    public void SumParameter(integer Y){
        integer A=0;
        for(integer i=1;i<=Y;i++){
            A=A+i;
        }
        system.debug('Sum of no from zero to parameter is '+A);
    }
    
    // Question 5 Simple interest *************
    public void SimpleInterest(decimal P,decimal R,decimal T){
        decimal SI;
        SI=P*R*T/100;
        system.debug('Simple interest is '+SI);
    }
    
    //Constructor Example *************
    string str='Welcome To Salesforce World!!';
    public ESPLProgrammaticModel1Class(){
        system.debug(str);
    } 
    public ESPLProgrammaticModel1Class(string A){
        system.debug(A);
    }
    
    //*******************************
    Public integer calculator(String operation, Integer inp1 , Integer Inp2){
    
      string a,b,c,d;
        a='SUM'; b='SUB';c='MUL';d='DIV';
        integer Result;
        if(operation==a){
            Result=inp1+inp2;
        }
        else if(operation==b){
            Result=inp1-inp2;
        }
        else if(operation==c){
            Result=inp1*inp2;
        }
        else if(operation==d){
            Result=inp1/inp2;
        }
        system.debug('Result Is '+Result);
     Return Result;
    } 
}