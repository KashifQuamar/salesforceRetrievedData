public class searchContact{
@auraEnabled(cacheable=true)
public static list<contact> getresult(string first_name,string last_name,string emaill)
{

list<contact> newlist=[select id,name,email from contact where firstname=:first_name or lastname=:last_name  or email=:emaill];
system.debug(newlist);
return newlist;
}
@auraEnabled
public static void deleteresult(string d){
system.debug(d);
//List<contact> delcontact =[select id from contact where id =:d];
//System.debug(delcontact);
contact cc=new contact();
cc.id=d;
delete cc;
}

}