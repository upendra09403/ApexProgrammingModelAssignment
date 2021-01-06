public abstract class OOPSConceptsSet3 {
    
    public  integer amount=10;
    
    public static void callFromNonStatic(){
        system.debug('We need to call this static method from another(nonstatic)Class');
    }
    public void PrintHelloWorld(){
        system.debug('Hello World!!!');
    }
   /* We can not use non static variable inside static variable
      public static void GetAmount(integer amt){
        amount=amt;
    } */
    public  void GetAmount1(integer amt){
        amount=amt;
}
    public abstract void AmountCalculation(integer count);
        
}