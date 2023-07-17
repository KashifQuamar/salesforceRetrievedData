trigger Bose on Batch__c (before insert,before update) {
list<Account> acc=new list<Account>();
list<String> naam=new list<String>();
for(Batch__c b:trigger.new){
 naam.add(b.Company_Name__c);
}
acc=[select Name from account where name in:naam];
System.debug(acc);
}