trigger orderNoOne on Opportunity (before insert) {
for(opportunity opp:trigger.new)
{
opp.OrderNumber__c='1';

}

}