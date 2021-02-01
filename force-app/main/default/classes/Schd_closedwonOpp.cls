public class Schd_closedwonOpp implements schedulable{
    public void execute(SchedulableContext Sc){
        Batch_ClosedWonOpp b=new Batch_ClosedWonOpp();
        database.executeBatch(b);
    }
}