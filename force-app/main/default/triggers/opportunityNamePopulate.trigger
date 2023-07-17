trigger opportunityNamePopulate on Opportunity (before insert,before update) {
list<opportunity> opplist= new list<opportunity>();
    
     if(trigger.isinsert)
     {
         if(trigger.isbefore)
         {
           opplist.addAll(trigger.new);
           opportunityNaming.oppNameing(opplist);
         }
      }
    if(trigger.isupdate)
    {
        if(trigger.isbefore)
        {
            
                 for(opportunity opp:trigger.new)
                 {
                     if(opp.accountid!=trigger.oldmap.get(opp.id).accountid || opp.type!=trigger.oldmap.get(opp.id).type || opp.recordtypeid!=trigger.oldmap.get(opp.id).recordtypeid)
                     {
                        opplist.add(opp); 
                         system.debug(opp);
                     }
                 }
          
           
           if(opplist.size()>0)
           {
            opportunityNaming.oppNameing(opplist);   
           }
             
          
        }
    }
      
      
}