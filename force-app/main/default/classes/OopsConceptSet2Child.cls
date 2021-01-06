public class OopsConceptSet2Child extends OopsConceptSet2Class{
 public override double CalculateAmt(integer count){
        system.debug('Calculated value is '+amount*count*0.10);
        return (amount*count*0.10);
    }
}