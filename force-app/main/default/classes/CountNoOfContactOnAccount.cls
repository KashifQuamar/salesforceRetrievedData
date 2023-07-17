public class CountNoOfContactOnAccount {
   @future
    public static void calulateNoOfContacts(list<id> accids)
    {
        list<Account> Acc_query=[select id,(select id from contacts) from account where id in:accids];
         list<Account> acclist=new list<Account>();
        for(Account acc:Acc_query)
        {
            Account accountCon= new Account();
            accountCon.id=acc.id;
            accountCon.Total_no_of_contact__c=acc.contacts.size();
            acclist.add(accountCon);
        }
        if(acclist.size()>0)
        {
            update acclist;
        }
    }
}