@istest
public class Test_OppsConcepts {
    @istest static void oppsTest(){
         integer intNum=20;
        test.startTest();
        OOPSConceptsSet3 op=new OOPSConceptsSet3Child();
        OOPSConceptsSet3.callFromNonStatic();
        op.PrintHelloWorld();
        op.GetAmount1(50);
        op.AmountCalculation(10);
        ESPLProgrammaticModel1Class esp=new OopsSet1Child();
        esp.CalculateAmt(5);
        test.stopTest();
    }
    @istest static void set2Oops(){
        integer intNum=20;
        test.startTest();
        OopsConceptSet2Class op=new OopsConceptSet2Class();
        OopsConceptSet2Class op1=new OopsConceptSet2Class(40);
        op.CalculateAmt(5);
        OopsConceptSet2Class op2=new OopsConceptSet2Child();
        op2.CalculateAmt(10);
        test.stopTest();
    }
    @istest static void abstractIvehicle(){
        test.startTest();
        IVehicle iv=new TruckVehicle();
        iv.speed();
        iv.ModelName();
        iv.model();
        TruckVehicle veh=new TruckVehicle();
        veh.speed();
        abstractClassSet2 abs=new abstractClassSet2Child();
        abs.CalculateAmount(10);
        test.stopTest();
    }
    @istest static void staticBlockTest(){
      integer count=10;
     integer instanceCount=30;
        test.startTest();
        staticVariableExClass st=new staticVariableExClass();
        st.setCount(100);
        st.setInstanceCount(50);
        st.printValues();
        test.stopTest();
    }
}