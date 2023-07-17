trigger add_users_to_account_manager on new_customers__c (after insert,after delete,after update) {
list<id> acc_id =new list<id>();
list<id> user_id =new list<id>();
map<id,list<id>> newmap=new map<id,list<id>>();
map<id,list<id>> newmap2=new map<id,list<id>>();
list<AccountTeamMember> at_list= new list<AccountTeamMember>();
list<AccountTeamMember> at_list2= new list<AccountTeamMember>();
list<AccountTeamMember> atm_q=new list<AccountTeamMember>();
if(trigger.isinsert){
for(new_customers__c c:trigger.new)
{
AccountTeamMember newobj= new AccountTeamMember();
newobj.accountid=c.account__c;
newobj.userid=c.user__c;
 newobj.TeamMemberRole='Account Manager';
 at_list.add(newobj);
}

insert at_list;
}
if(trigger.isdelete){
for(new_customers__c d:trigger.old)
{
acc_id.add(d.account__c);
user_id.add(d.user__c);
}
}
//

if(trigger.isupdate){

for(new_customers__c e:trigger.old)
{
if(trigger.newmap.get(e.id).user__c!= trigger.oldmap.get(e.id).user__c){
  acc_id.add(e.Account__c);
  user_id.add(e.user__c);
}}


for(new_customers__c f:trigger.new)
{
if(trigger.oldmap.get(f.id).user__c!= f.user__c){

  acc_id.add(f.Account__c);
   user_id.add(f.user__c);
  }

}

}




//
System.debug(acc_id);
atm_q=[select id,userid,accountid from AccountTeamMember where accountid in:acc_id and userid in:user_id];
System.debug(atm_q);
for(AccountTeamMember d:atm_q)
{
system.debug(d);
system.debug(d.AccountId);
system.debug(d.userid);
system.debug(d.id);
AccountTeamMember newobj= new AccountTeamMember();
newobj.id=d.id;


 at_list.add(newobj);
}
System.debug(at_list);
System.debug(at_list2);
if((trigger.isdelete)||  (trigger.isupdate))
{
delete at_list;
}

}