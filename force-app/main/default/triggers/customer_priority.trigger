trigger customer_priority on Contact (after insert,after delete,after update) {
list<id> acc_id=new list<id>();
map<id,map<string,list<string>>> newmap= new map<id,map<string,list<string>>>();
list<account> accs_list= new list<account>();
list<contact> con_q=new list<contact>();
if(trigger.isinsert){
for(contact c:trigger.new)
{
System.debug(c.firstname);
acc_id.add(c.accountid);
}
}
if(trigger.isdelete)
{
for(contact e:trigger.old)
{
acc_id.add(e.accountid);
}
}
//update
//
if(trigger.isupdate){

for(Contact c:trigger.old)
{
if(trigger.newmap.get(c.id).accountid!= trigger.oldmap.get(c.id).accountid){
  acc_id.add(c.AccountId);

}}


for(Contact c:trigger.new)
{
if(trigger.oldmap.get(c.id).accountid!= c.accountid){

  acc_id.add(c.AccountId);
  }

}

}







//
con_q=[select id,accountid,Customer_field__c,firstname,lastname,name from contact where accountid in:acc_id and Customer_field__c !=null order by createddate asc] ;
System.debug(con_q);
for(contact d:con_q)
{
system.debug(d.name);
system.debug(d.lastname);
map<string,list<string>> newmap2=new map<string,list<string>> ();
if(newmap.containskey(d.accountid))
{
system.debug(newmap);
 newmap2=newmap.get(d.accountid);
list<string> cus_name=new list<string>();
if(newmap2.containskey(d.Customer_field__c)){
 cus_name=newmap2.get(d.Customer_field__c);
system.debug(cus_name);
cus_name.add(d.name);
newmap2.put(d.Customer_field__c,cus_name);
}
else {
//newmap.put(d.account__c,new set<id>{d.user__c});
newmap2.put(d.Customer_field__c,new list<string>{d.name});
}

 newmap.put(d.accountid,newmap2);
}
else{
 //newmap.put(d.account__c,new set<id>{d.user__c});
map<string,list<string>> newmap3 =new map<string,list<string>>();
newmap3.put(d.Customer_field__c,new list<string>{d.name});
newmap.put(d.accountid,newmap3);
system.debug(newmap);
}
}
system.debug(newmap);

for(id i:acc_id)
{
Account acc=new account();
acc.id=i;
if(newmap.containskey(i)){

if(newmap.get(i).containskey('High')){
    acc.CustomerPriority__c='High';
    acc.Customer_with_highest_priority__c=newmap.get(i).get('High')[0];
    accs_list.add(acc);
}
else if(newmap.get(i).containskey('Mdeium')){
    acc.CustomerPriority__c='Medium';
    acc.Customer_with_highest_priority__c=newmap.get(i).get('Mdeium')[0];
    accs_list.add(acc);
}
else if(newmap.get(i).containskey('Low')){
 acc.CustomerPriority__c='Low';
    acc.Customer_with_highest_priority__c=newmap.get(i).get('Low')[0];
    accs_list.add(acc);
}
else{
System.debug('hello');
acc.CustomerPriority__c='none';
    acc.Customer_with_highest_priority__c='';
    accs_list.add(acc);
}

}
else{
System.debug('hello');
acc.CustomerPriority__c='none';
    acc.Customer_with_highest_priority__c='';
    accs_list.add(acc);
}
}
update accs_list;
}