trigger creating_contacts on Account (after insert) {
list<id> group1= new list<id>();

for(Account a:trigger.new){
group1.add(a.Id);

}
//createcontact.formcontact(group1);
list<contact> clist=new list<contact>();
list<Account> kashif=new list<Account>();
kashif=[select name,NumberofLocations__c from account where id in :group1];
System.debug(kashif);
for(Account c:kashif){

for(Decimal i=0;i<c.NumberofLocations__c;i++)
{
contact con=new contact();
con.lastname=c.name+i;
con.AccountId=c.id;
clist.add(con);
}

//System.debug(sno);
}
insert clist;
}