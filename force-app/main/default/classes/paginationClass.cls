public class paginationClass{
@AuraEnabled(cacheable=true)
public static list<contact> getrecords(){
list<contact> newcon=[select id,name,email from contact order by createddate desc];
system.debug(newcon);
return newcon;
}
@AuraEnabled
public static void delrec(string c){
system.debug(c);
contact cc=new contact();
cc.id=c;
delete cc;
}

}