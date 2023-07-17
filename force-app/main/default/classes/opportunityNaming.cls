public class opportunityNaming {
 
    public static void oppNameing(list<opportunity> opportunitylist)
    {
        system.debug(opportunitylist);
        set<id> accid=new set<id>();
         set<id> recordTypeId=new set<id>();
        set<string> oppType= new set<string>();
         map<id,recordtype> recordTypeMap=new map<id,recordtype>();
        set<string> allName= new set<string>();
          map<id,string> recordTypeNameMap=new map<id,string>();
         for(opportunity opp:opportunitylist)
         { 
            accid.add(opp.accountid);  
             system.debug(opp.accountid);
             recordTypeId.add(opp.recordtypeid);
             system.debug(opp.recordtypeid);
              oppType.add(opp.type);  
             system.debug(opp.type);
         }
        // fetching the recordtype of opportunity
         recordTypeMap.putAll([select id, Name from recordtype where id in :recordTypeId]);
        system.debug(recordTypeMap);
        // fetching data from opportunity
         list<opportunity> opp_q=[select name from opportunity where accountid in:accid and type in:oppType and recordtypeid in:recordTypeId];
         system.debug(opp_q);
        if(opp_q.size()>0){
        for(opportunity opp:opp_q)
        {
           allName.add(opp.name);
         }
         }
        if(trigger.isinsert)
        {
            if(trigger.isbefore)
            {
                 Map<id, account> accountDataMap=new Map<id, account>();
                   accountDataMap.putAll([select id, Name from Account where id in :accid]);
                map<string,integer> allOpportunityNames=new  map<string,integer>();
               
                allOpportunityNames=extractName(allName);
                system.debug(allOpportunityNames);
                for(opportunity opp:opportunitylist)
                {
                     Account accountData=accountDataMap.get(opp.accountId);
                      Recordtype recordData=recordTypeMap.get(opp.recordtypeid);
                    
                    string c=accountData.name+'--'+recordData.name+'--'+opp.type+'--';
                       string d=c.replaceAll('[^A-Za-z]','');
                    system.debug(d);
                    
                    if(allOpportunityNames.containskey(d)){
                         allOpportunityNames.put(d,(allOpportunityNames.get(d)+1));
                          opp.name=c+allOpportunityNames.get(d);
                        system.debug(opp.name);
                    }
                    else{
                        allOpportunityNames.put(d,1);
                       opp.name=c+allOpportunityNames.get(d);
                         system.debug(opp.name);
                     
                    }
                     
            }
        }
      
      
        
    }
  
        
        //update
         if(trigger.isupdate)
          {
           if(trigger.isbefore)
          {
                Map<id, account> accountDataMap=new Map<id, account>();
                   accountDataMap.putAll([select id, Name from Account where id in :accid]);
              
               map<string,integer> allOpportunityNames=new  map<string,integer>();
               list<opportunity> opplist=new list<opportunity>();
                allOpportunityNames=extractName(allName);
              
           for(opportunity opp:opportunitylist)
         { 
             Account accountData=accountDataMap.get(opp.accountId);
                      Recordtype recordData=recordTypeMap.get(opp.recordtypeid);
              string c=accountData.name+'--'+recordData.name+'--'+opp.type+'--';
             system.debug(c);
                       string d=c.replaceAll('[^A-Za-z]','');
                    system.debug(d);
             system.debug(allOpportunityNames);
                    if(allOpportunityNames.containskey(d)){
                        allOpportunityNames.put(d,allOpportunityNames.get(d)+1);
                 opp.name=c+allOpportunityNames.get(d);
              allOpportunityNames.put(d,allOpportunityNames.get(d)+1);
                      
         }
             else{
                 allOpportunityNames.put(d,1);
                
               opp.name=c+allOpportunityNames.get(d);
              
             }
         }
             
          }
          }
    }
 
  
  public static  map<string,integer> extractName(set<string> newstring)
  {
      map<string,integer> newmap= new  map<string,integer>();
      list<string> allnaam= new list<string>();
      allnaam.addAll(newstring);
      system.debug(allnaam);
      if(newstring.size()>0){
     for(integer i=0;i<allnaam.size();i++)
     {
        string str;
           String[] strArr = allnaam[i].split('--');
                         String strNumber = '';
                          Integer myNumber;
                    
                          if(strArr.size() >3){
                          strNumber = strArr[3];
                              
                           myNumber = Integer.valueOf(strNumber );
                             
                               str = allnaam[i].replaceAll('[^A-Za-z]','');
                              
                              if(newmap.containskey(str))
                              {
                                  if(newmap.get(str)<myNumber){
                                     newmap.put(str,myNumber);

                                              }
                                                               
                                    }
                                 else{
                                     newmap.put(str,myNumber); 
                                 }
                                 
                                 }
                                 }
           system.debug(newmap);
             
     }
      return newmap;        
  }
    }