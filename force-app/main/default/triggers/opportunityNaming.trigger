trigger opportunityNaming on Opportunity (before insert,after delete,after update) {

        set<id> accid=new set<id>();
        list<opportunity> opplist=new list<opportunity>();
        map<id,integer> newmap=new map<id,integer>();
    // trigger insert is before
    
        if(trigger.isinsert){
            if(trigger.isbefore){
                 for(opportunity opp:trigger.new)
                 {
                     accid.add(opp.accountid);
                 }
            }
         }
    // trigger delete 
          if(trigger.isdelete){
               for(opportunity opp:trigger.old)
               {
                  accid.add(opp.accountid);
               }
             
         }
     // trigger update 
          if(trigger.isupdate){
               if(!preventRecursion.status){
                   
                    preventRecursion.status=true;
                      for(opportunity opp:trigger.new)
                        {
                          accid.add(trigger.oldmap.get(opp.id).accountid);
                          accid.add(opp.accountid);
            
                        }
          }
          }
    
  // query the opportunity object
         list<opportunity> opp_q=[select id,name,accountid,account.name,type,recordtypeid from opportunity where accountid in:accid];
      
        for(opportunity opp:opp_q)
        {
          opportunity pop= new opportunity();
          string recordtypename = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.recordtypeid).getname();
             if(newmap.containskey(opp.accountid))
               {
                  integer countNo=newmap.get(opp.accountid);
                  countNo=CountNo+1;
                  newmap.put(opp.accountid,countNo);
                   
                  pop.id=opp.id;
                  pop.name=opp.account.name+'//'+opp.type+'//'+recordtypename+'//'+newmap.get(opp.accountid);
             
                opplist.add(pop);
              }
            else{
                  newmap.put(opp.accountid,1);
                   pop.id=opp.id;
                   pop.name=opp.account.name+'//'+opp.type+'//'+recordtypename+'//'+newmap.get(opp.accountid);
           
                opplist.add(pop);
          }
        }
  
        
        
        // trigger insert
         if(trigger.isinsert){
              if(trigger.isbefore)
              {
                 Map<id, account> accMap=new Map<id, account>();
                  accMap.putAll([select id, Name from Account where id in :accId]);
                  
                    for(opportunity opp:trigger.new)
                     {
                        Account a=accMap.get(opp.accountId);
                        string recordtypename = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.recordtypeid).getname();
          
                         if(newmap.isempty())
                            {
                              opp.name=a.name+'//'+opp.type+'//'+recordtypename+'//'+1;
                            }
            
                         else{
                               opp.name=a.name+'//'+opp.type+'//'+recordtypename+'//'+(newmap.get(opp.accountid)+1);
                 
                             }
             
                    }
         }
        }
        
    // delete and update
    if(trigger.isupdate)
    {
        update opplist;
    } 
     if(trigger.isdelete)
    {
        update opplist;
         preventRecursion.status=false;
        
    } 
    
   
}