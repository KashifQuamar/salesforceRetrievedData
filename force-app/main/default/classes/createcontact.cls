public class createcontact{
public static void formcontact(list<id> sno){
list<contact> clist=new list<contact>();
list<Account> kashif=new list<Account>();
kashif=[select name,NumberofLocations__c from account where id in :sno];
System.debug(kashif);
for(Account c:kashif){

for(Decimal i=0;i<c.NumberofLocations__c;i++)
{
contact con=new contact();
con.lastname=c.name+i;
con.AccountId=c.id;
clist.add(con);
}

System.debug(sno);
}
insert clist;
}
}