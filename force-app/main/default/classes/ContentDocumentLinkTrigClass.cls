public class ContentDocumentLinkTrigClass {
    public static void onAfterInser(list<ContentDocumentLink> lstCntLinks){
        String strObjPrefix;
        //Set<Id> setCntDocIds = new set<Id>();
        List<Id> setAccIds = new List<Id>();
        for(ContentDocumentLink clIterator : lstCntLinks) {
            strObjPrefix = String.valueOf(clIterator.LinkedEntityId).substring(0, 3);
            if(strObjPrefix == Account.sObjectType.getDescribe().getKeyPrefix()) {
                //setCntDocIds.add(clIterator.ContentDocumentId);
                setAccIds.add(clIterator.LinkedEntityId);
            }
        }
            

  List<Approval.ProcessSubmitRequest> approvalReqList=new List<Approval.ProcessSubmitRequest>();

   // create the new approval request to submit     
        for(integer i=0;i<setAccIds.size();i++){
   Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();    
   req.setComments('Submitted for approval. Please approve.');
   req.setObjectId(setAccIds[i]); 
   approvalReqList.add(req);         

   }     
// submit the approval request for processing         

List<Approval.ProcessResult> resultList = Approval.process(approvalReqList);         

// display if the reqeust was successful

        for(Approval.ProcessResult result: resultList ){         
System.debug('Submitted for approval successfully: '+result.isSuccess());       
}
}
}