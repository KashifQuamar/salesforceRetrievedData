trigger updating_no_of_emails_on_account on Opportunity (after insert,after update) {
map<id,list<string>> newmap=new map<id,list<string>>();
if(trigger.isinsert){
for(opportunity opp:trigger.new)
{
if(newmap.containskey(opp.accountid))
{
list<string> newlist=newmap.get(opp.accountid);
newlist.add(opp.email__c);
newmap.put(opp.accountid,newlist);
}
else{
newmap.put(opp.accountid,new list<string>{opp.email__c});
}
}
}
System.debug('this is newmap opportunity'+newmap);
//
if(trigger.isdelete)
{
for(opportunity e:trigger.old)
{
if(newmap.containskey(e.accountid))
{
list<string> newlist=newmap.get(e.accountid);
newlist.add(e.email__c);
newmap.put(e.accountid,newlist);
}
else{
newmap.put(e.accountid,new list<string>{e.email__c});
}
}
}
//update
//
if(trigger.isupdate){

for(opportunity opo:trigger.old)
{
if((trigger.newmap.get(opo.id).accountid!= trigger.oldmap.get(opo.id).accountid) ||(trigger.newmap.get(opo.id).email__c!= trigger.oldmap.get(opo.id).email__c) ){
 
if(newmap.containskey(opo.accountid))
{
list<string> newlist=newmap.get(opo.accountid);
newlist.add(opo.email__c);
newmap.put(opo.accountid,newlist);
}
else{
newmap.put(opo.accountid,new list<string>{opo.email__c});
}
}}


for(opportunity pop:trigger.new)
{
if((trigger.oldmap.get(pop.id).accountid!= pop.accountid) ||(trigger.oldmap.get(pop.id).email__c!= pop.email__c)){

 if(newmap.containskey(pop.accountid))
{
list<string> newlist=newmap.get(pop.accountid);
newlist.add(pop.email__c);
newmap.put(pop.accountid,newlist);
}
else{
newmap.put(pop.accountid,new list<string>{pop.email__c});
}
  }

}

}


//
System.debug('this is opportunity1234'+newmap);
calculating_opportunity_based_on_email.get_email_and_accid(newmap);
 
}