trigger ischecked on Account (before insert,after update) {
 list<id> acc_id=new list<id>();

 for(account a:trigger.new)
 {
 if(trigger.isinsert){
 if(a.Document_Upload__c==true)
 {
 a.addError('You cannot check this field');
 }
 }
 if(trigger.isupdate)
 {
 if(trigger.newmap.get(a.id).Document_Upload__c!= trigger.oldmap.get(a.id).Document_Upload__c){
  system.debug('system1');
  a.addError('this is not acceptable2');
}


 if(trigger.oldmap.get(a.id).Document_Upload__c!= a.Document_Upload__c){
 a.addError('this is not acceptable3');
 
  
  }
 }
 system.debug(a.Document_Upload__c);
}
}