public virtual class ESPLProgrammaticModel1Class {
    
    protected double amount=50;
    
    public static boolean numberCheck(integer A){
        boolean isEven;
        if(math.mod(A,2)==0){
            system.debug('The number is an Even number');
            isEven=true;
        }
        else if(math.mod(A,2)!=0){
            system.debug('The number is an Odd number');
            isEven=false;
        }
        return isEven;
    }
    
    //Checking even and odd without mod function
    public static boolean numberCheck1(integer a){
        boolean isEven;
        if((a/2)*2==a){
          system.debug('The number is an Even number'); 
            isEven=true;
        }
        else if((a/2)!=a){
            system.debug('The number is an Odd number');
            isEven=false;
        }
        return isEven;
    }
    
    
    // Ques 2 *******************
    public static void PrintArray(integer X){
        for(integer i=1;i<=X;i++){
            system.debug('Welcome to Salesforce!!!');
        }
    }
    
    // Question 3 ***********************
    // Need to do this without using sort function(Change)
    
    public static list<integer> SortAscending(integer[] nums){
        nums.sort();
        system.debug('Ascending order is '+nums);
        integer[] A=new list<integer>();
        for(integer i=nums.size()-1;i>=0;i--){
            A.add(nums.get(i));
        }
        system.debug('Numbers in Descending orders are '+A);
        return A;
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
    
    public set<integer> findDuplicate(integer[] nums){
        Set<integer>intList=new Set<integer>();
       
        for(integer i=0;i<nums.size();i++){
            for(integer j=i+1;j<nums.size();j++){
                if(nums[i]==nums[j]){
                    //system.debug('The number '+nums[i]+' is a duplicate number');

                    intList.add(nums[i]);
                } 
            }
        }
        system.debug('Duplicate numbers in array are: '+intList);
        return intList;
    }
    public Map<integer,integer> numberOccurence(integer[] nums){
        map<integer,integer>MapList=new map<integer,integer>();
        nums.sort();
        for(integer i=0;i<nums.size();i++){
            integer count=1;
        for(integer j=i+1;j<nums.size();j++){
            if(nums[i]==nums[j]){
                count++;
            }   
        }
            if(count>1){
                system.debug(nums[i]+' : '+count);
                MapList.put(nums[i],count);
                i=i+(count-1);
            }else{
               system.debug(nums[i]+' : '+count); 
                MapList.put(nums[i],count);
            }
        }
        system.debug(MapList);
        return MapList;
    }
   
    public integer SumParameter(integer Y){
        integer a=0;
        for(integer i=1;i<=Y;i++){
            a=a+i;
        }
        system.debug('Sum of no from zero to parameter is '+A);
        return A;
    }
    
    // Question 5 Simple interest *************
    public decimal SimpleInterest(decimal P,decimal R,decimal T){
        decimal SI;
        SI=P*R*T/100;
        system.debug('Simple interest is '+SI);
        return SI;
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
     return Result;
    } 
    
    
    public virtual double CalculateAmt(integer count){
        system.debug('Calculated value is '+amount*count);
        return (amount*count);
    }
}