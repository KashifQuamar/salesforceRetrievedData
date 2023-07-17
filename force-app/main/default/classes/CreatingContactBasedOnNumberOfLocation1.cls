public class CreatingContactBasedOnNumberOfLocation1{
@InvocableMethod
public Static void createContact(List<string> kashifanmol){
system.debug(kashifanmol);
list<contact> updatedCList=new list<contact> ();
list<account> shrishtee=[select numberoflocations__c from account where id IN:kashifanmol];
for(account trishu:shrishtee){
system.debug(trishu.numberoflocations__c);
for(decimal i=0;i<trishu.numberoflocations__c;i++){
contact c = new contact();
c.lastname='c'+i;
c.accountid=trishu.id;
updatedCList.add(c);
}

}
insert updatedCList;
 }


}