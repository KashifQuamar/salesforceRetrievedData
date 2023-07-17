trigger titleUpdate on Contact (before update) {
map<id,string> conmap= new map<id,string>();
set<id> accid= new set<id>();
list<contact> allcontacts=new list<contact>();
for(Contact c:trigger.new)
{
if(trigger.newmap.get(c.id).title!= trigger.oldmap.get(c.id).title){
conmap.put(c.accountid,c.title);
}

}
list<contact> con_q=[select id,accountid from contact where accountid in:conmap.keyset()];
for(contact con:con_q)
{
contact cont=new contact();
cont.id=con.id;
cont.title=conmap.get(con.accountid);
allcontacts.add(cont);
}
if(trigger.isafter){
if(trigger.isupdate){
update allcontacts;
}
}

}