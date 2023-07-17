trigger no_of_opportunity on Account (after update,after insert) {

map<id,list<string>> newmap=new map<id,list<string>>();
if(trigger.isinsert){
for(Account a:trigger.new)
{

if(newmap.containskey(a.id))
{
list<string> newlist=newmap.get(a.id);
newlist.add(a.email__c);
newmap.put(a.id,newlist);
}
else{
newmap.put(a.id,new list<string>{a.email__c});
}
}
}

//
if(trigger.isupdate){


for(Account d:trigger.new)
{
if(trigger.oldmap.get(d.id).email__c!= d.email__c){

if(newmap.containskey(d.id))
{
list<string> newlist=newmap.get(d.id);
newlist.add(d.email__c);
newmap.put(d.id,newlist);
}
else{
newmap.put(d.id,new list<string>{d.email__c});
}
  }

}

}

System.debug('this is account'+newmap);
calculating_opportunity_based_on_email.get_email_and_accid(newmap);
 
}