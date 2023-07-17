public class QueableClass implements Queueable {
    private list<id> accids=new list<id>();
     list<Account> acclist=new list<account>();
    public QueableClass(list<Account> acclist){
        for(Account acc:acclist)
        {
          accids.add(acc.id);  
        }
     
       
    }
    public void execute(QueueableContext context)
    {
        list<Account> acc_q=[select id,(select id from contacts) from account where id in:accids];
         for(Account acc:acc_q)
        {
            Account accData=new Account();
            accData.id=acc.id;
            accData.Total_no_of_contact__c=acc.contacts.size();
            acclist.add(accData);
        }
        if(acclist.size()>0)
        {
            update acclist;
        }
        
    }

}