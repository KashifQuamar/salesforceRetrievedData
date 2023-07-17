trigger ischeck on Contact (after insert) {
list<id> acc_id= new list<id>();
for(contact c:trigger.new)
{
acc_id.add(c.accountid);
system.debug(c.Contact_type__c);
system.debug(c.Ischecked__c);
}

}