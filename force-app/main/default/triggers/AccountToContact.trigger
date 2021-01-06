trigger AccountToContact on Account (after insert) {
 list<contact>conList=new list<contact>();
 for(account acc:trigger.new){
     contact con=new contact();
     con.lastname=acc.name+' contact';
     con.accountid=acc.id;
     conList.add(con);
 }
 insert conList;
}