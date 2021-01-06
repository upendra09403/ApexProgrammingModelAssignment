public class staticVariableExClass {
   private static integer count=10;
    private integer instanceCount=30;
    
    public void setCount(integer val){
        count=val;
    }
    public void setInstanceCount(integer val){
        instanceCount=val;
    }
    Public void printValues(){
        system.debug('Instance value '+instanceCount);
        system.debug('Static value '+count);
    }
}