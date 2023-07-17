trigger No_of_contact on Contact (after insert,after delete,after update) {
list<ID> ls= new list<ID>();
list<ID> del= new list<ID>();
list<Account> a= new list<Account>();
list<Account> aco= new list<Account>();
Integer h=0;
list<contact> con= new list<contact>();
list<String> newlist= new list<String>();
Map<ID,list<Id>> newmap= new Map<ID,list<Id>>();
Map<id,Integer>conmap= new Map<id,Integer>();
if(trigger.isinsert){
for(contact c:trigger.new)
{
 ls.add(c.AccountId);
}

}
if(trigger.isdelete){
for(Contact c:trigger.old)
{
  ls.add(c.AccountId);
}}

if(trigger.isupdate){

for(Contact c:trigger.old)
{
if(trigger.newmap.get(c.id).accountid!= trigger.oldmap.get(c.id).accountid){
  ls.add(c.AccountId);

}}


for(Contact c:trigger.new)
{
if(trigger.oldmap.get(c.id).accountid!= c.accountid){

  ls.add(c.AccountId);
  }

}

}


con=[select id,name ,accountid from contact where AccountId in:ls];

 for(Contact c:con)
 {
if(newmap.containsKey(c.AccountId)) {
        List<Id> usersId = newmap.get(c.AccountId);
        
        usersId.add(c.id);
       newmap.put(c.AccountId,usersId);
    } else {
        newmap.put(c.AccountId, new List<Id> { c.Id });
    }  
 }
 System.debug(newmap);
 for(Id yd:ls){
 if(newmap.containskey(yd)){
Account at=new Account();
at.Total_no_of_contact__c=newmap.get(yd).size();
at.id=yd;
a.add(at);
}
else{
Account at=new Account();
at.Total_no_of_contact__c=0;
at.id=yd;
a.add(at);


}
}
if(!a.isEmpty()){
update a;
}


}