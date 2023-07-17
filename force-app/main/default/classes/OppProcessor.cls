public class OppProcessor implements Database.Batchable<sObject>,Database.stateful{
    
public integer recordCount=0;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select Id,Name from opportunity]);
    }
    
    public void execute(Database.BatchableContext bc, List<Opportunity> opps){
      
        for(Opportunity op:opps)
        {
           op.LeadSource='Web';
           op.Email__c='samar@gmail.com';            
        }
        system.debug(opps);
        update opps;
        recordCount=recordCount+ opps.size();
    }
    public void finish(Database.BatchableContext bc)
    {
        system.debug('Total records Processed='+recordCount);
    }
}