trigger creating_contract on Chance__c (after insert,after update) {
for(chance__c c:trigger.new)
{
if(c.status__c=='Confirmed')
{
agreement__c ag=new agreement__c();
ag.name=c.name;
ag.book__c=c.Book_Name__c;
ag.email__c=c.email__c;
ag.address__c=c.address__c;
ag.ALL_Products__c=c.All_Products_selected__c;
insert ag;
}
}

}