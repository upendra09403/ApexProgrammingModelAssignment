@isTest
public class Test_ESPLProgrammaticModel1Class {

    @isTest static void isEven(){
        
        boolean isEven =ESPLProgrammaticModel1Class.numberCheck(10);
        boolean isEven1=ESPLProgrammaticModel1Class.numberCheck(11);

        system.assertEquals(isEven, true);
        system.assertEquals(isEven1, false);
        boolean isEven2=ESPLProgrammaticModel1Class.numberCheck1(11);
        boolean isEven3=ESPLProgrammaticModel1Class.numberCheck1(10);
        system.assertEquals(isEven2, false);
        system.assertEquals(isEven3, true);
        //printing array
        ESPLProgrammaticModel1Class.PrintArray(2);
        
        integer[] arrayInt=new integer[]{1,5,4,2,6};
          arrayInt.sort();
        integer[] intArr=new integer[]{6,4,1,2,5};
            //ESPLProgrammaticModel1Class.SortAscending(intArr);
        system.assertNotEquals(arrayInt, ESPLProgrammaticModel1Class.SortAscending(intArr));
        
    }
    @istest static void findMinMaxDup(){
        integer[] arrayInt=new integer[]{1,5,4,2,2,5,6};
          ESPLProgrammaticModel1Class es=new ESPLProgrammaticModel1Class();
        ESPLProgrammaticModel1Class es1=new ESPLProgrammaticModel1Class('Welcome');
        integer a=es.FindMinValue(arrayInt);
        system.assertEquals(1, a);
        integer b=es.FindMaxValue(arrayInt);
        system.assertEquals(6, b);
        set<integer>intSet=new set<integer>{2,5};
            set<integer>SetResult=es.findDuplicate(arrayInt);
        system.assertEquals(intSet, SetResult);
        
        //Number of occurence
        map<integer,integer>mapArray=new map<integer,integer>();
        arrayInt.sort();
        mapArray.put(1,1);
        mapArray.put(2,2);
        mapArray.put(4,1);
        mapArray.put(5,2);
        mapArray.put(6,1);
            system.assertEquals(mapArray, es.numberOccurence(arrayInt));
        
        //sum parameter
        integer res=es.SumParameter(5);
        system.assertEquals(15, res);
        //SI Calculation
        decimal result=es.SimpleInterest(1000,3,4);
        system.assertEquals(120, result);
        //calculator
        system.assertEquals(12, es.calculator('SUM',8,4));
        system.assertEquals(1, es.calculator('SUB',5,4));
        system.assertEquals(20, es.calculator('MUL',5,4));
        system.assertEquals(2, es.calculator('DIV',8,4));
        
        system.assertEquals(250, es.CalculateAmt(5));
    }
    
}