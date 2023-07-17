trigger Batching on Batch__c (before insert,before update) {
Map<string,id> accmap=new Map<string,id>();
list<Account> acc=new list<Account>();
list<String> naam=new list<String>();
for(Batch__c b:trigger.new){
 naam.add(b.Company_Name__c);
}
acc=[select id,Name from account where name in:naam];
for(account a:acc)
{
accmap.put(a.name,a.id);
}
for(Batch__c d:trigger.new){
if(accmap.containskey(d.Company_Name__c)){
d.Account__c=accmap.get(d.Company_Name__c);
}
else{
d.Account__c=null;
}

}
}