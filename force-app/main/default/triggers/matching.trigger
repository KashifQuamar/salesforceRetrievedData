trigger matching on Account (before insert) {

Map<String,String> recent=new Map<String,String>();
Map<String,String> previous=new Map<String,String>();
List<Account> hal = new List<Account>();
for(Account a:trigger.new){
System.debug(a.rating);
recent.put(a.Name,a.Rating);

}

hal=[select id,name,rating from account where name in :recent.keySet()];
if(hal!=null)
{

for(Account b:hal)
{
 previous.put(b.Name,b.Rating);
}
for(Account c:trigger.new){
if(recent.get(c.name)!=null){
System.debug(c.name);
System.debug(recent.get(c.name));
System.debug(previous.get(c.name));
if(previous.get(c.name)==recent.get(c.name))
{
System.debug(c.name);
c.addError('This is not happening');
}
}
}
}
}