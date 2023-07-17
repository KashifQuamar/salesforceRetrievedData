trigger calculate_insurance on policy__c (before insert) {
Map<String,Map<String,Decimal>> discount= new Map<String,Map<String,Decimal>>();
Map<String,Decimal> CarMap=new Map<String,Decimal>();
CarMap.put('3 years',0.7);
CarMap.put('5 years',0.5);

Map<String,Decimal> HealthMap=new Map<String,Decimal>();
HealthMap.put('3 years',0.6);
HealthMap.put('5 years',0.4);
discount.put('Car Insurance',CarMap);
discount.put('Health Insurance',HealthMap);

for(Policy__c a:trigger.new)
{
System.debug(a.Policy_Ten__c);
System.debug(a.Policy_Type__c);
System.debug(discount.get(a.Policy_Type__c).get(a.Policy_Ten__c));
System.debug(discount.get(a.Policy_Type__c));
Decimal X=discount.get(a.Policy_Type__c).get(a.Policy_Ten__c);
 a.Amount_After_Discount__c=X*a.Policy_Amount__c;

}

}