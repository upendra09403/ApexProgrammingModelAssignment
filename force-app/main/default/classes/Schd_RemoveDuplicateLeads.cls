public class Schd_RemoveDuplicateLeads implements schedulable {
 public void execute(SchedulableContext Sc){
        Batch_RemoveDuplicateLeads b=new Batch_RemoveDuplicateLeads();
        database.executeBatch(b);
    }
}