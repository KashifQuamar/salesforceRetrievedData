trigger No_of_items on OpportunityLineItem (after insert,after delete) {
set<ID> opportunity_list= new set<ID> ();
list<OpportunityLineItem> oplq=new list<OpportunityLineItem>();
Map<id,set<String>> newmap= new Map<id,set<string>>();
list<opportunity> opp_list= new list<opportunity>();
if(trigger.isinsert){
    for(OpportunityLineItem opl:trigger.new)
    {
    System.debug(opl.OpportunityId);
     System.debug(opl.Product2Id);
     opportunity_list.add(opl.OpportunityId);
    }
    }
    system.debug(opportunity_list);
    if(trigger.isdelete)
    {
    for(OpportunityLineItem opl:trigger.old)
    {
    System.debug(opl.OpportunityId);
     System.debug(opl.Product2Id);
     opportunity_list.add(opl.OpportunityId);
    }
    }
    oplq=[select OpportunityId,product2.name from OpportunityLineItem where OpportunityId in: opportunity_list];
    System.debug(oplq);
    
    for(OpportunityLineItem opl2:oplq){
    if(newmap.containskey(opl2.OpportunityId))
    {
    set<string> newset= newmap.get(opl2.OpportunityId);
    newset.add(opl2.product2.name);
    newmap.put(opl2.OpportunityId,newset);
    }
    else{
    newmap.put(opl2.OpportunityId,new set<string> {opl2.product2.name});
    }
    }
   
    System.debug(newmap);
    system.debug(opportunity_list);
    for(id o_id:opportunity_list)
    {
    
    if(newmap.containskey(o_id))
    {
    opportunity opp =new opportunity();
     String s='';
    for(string i:newmap.get(o_id))
    {
       s= s+i+' , ';
    }
    opp.Name_of_Items__c=s;
    opp.id=o_id;
    opp_list.add(opp);
    }
    }
    system.debug(opp_list);
    update opp_list;
}