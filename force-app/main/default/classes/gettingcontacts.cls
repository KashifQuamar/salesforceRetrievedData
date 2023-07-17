Public class gettingcontacts{
@auraEnabled(cacheable=true)
public static list<contact> gettingContactfun(){
list<contact> newcon=[select id,name,accountid from contact limit 20];
return newcon;
}
}