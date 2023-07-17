trigger total_revenue on Opportunity (after insert) {
list<id> acc_id=new list<id>();
for(opportunity opp:trigger.new)
{
acc_id.add(opp.AccountId);
}

}