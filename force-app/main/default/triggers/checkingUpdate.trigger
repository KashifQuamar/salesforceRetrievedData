trigger checkingUpdate on Contact (after update) {
list<id> accid= new list<id>();
for(contact c:trigger.new)
{
accid.add(c.accountid);
accid.add(trigger.oldmap.get(c.id).accountid);
}
system.debug(accid);
}