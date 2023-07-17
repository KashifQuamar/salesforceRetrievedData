trigger restrict_update_after_7days on Account (before update) {
list<id> acc_id=new list<id>();
list<account> acc_q=new list<account>();
for(account a:trigger.new)
{
system.debug(a.name);
acc_id.add(a.id);
}
acc_q=[select id,LastModifiedById,createdbyId from account where id in:acc_id];
system.debug(acc_q);
for(Account a:acc_q)
{
//system.debug(a.createdDate);
system.debug(a.LastModifiedDate);
}
}