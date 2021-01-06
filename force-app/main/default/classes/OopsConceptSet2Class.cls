public virtual class OopsConceptSet2Class {

    protected double amount;
    public OopsConceptSet2Class(){
        amount=10;
        system.debug('This is the default constructor and the amount Is '+amount);
    }
    public OopsConceptSet2Class(Double amt){
        amount=amt;
        system.debug('This is the default Parameterized constructor and the amount Is '+amount);
    }
    public virtual double CalculateAmt(integer count){
        system.debug('Calculated value is '+amount*count);
        return (amount*count);
    }
}