public class infiniteScrolling{
@AuraEnabled(cacheable=true)
public static list<contact> getConData(integer no_of_limit,integer offsetlimit){
list<contact> newcon=[select id,name,email,account.name from contact order by CreatedDate desc limit:no_of_limit offset:offsetlimit];
system.debug(newcon);
return newcon;
}
@AuraEnabled(cacheable=true)
public static void delcon(string c){
contact cc=new contact();
cc.id=c;
delete cc;

}
}