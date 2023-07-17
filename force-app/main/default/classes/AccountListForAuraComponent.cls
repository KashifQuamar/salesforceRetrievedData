public class AccountListForAuraComponent {
  @AuraEnabled
    public static list<account> getAccountData(){
        list<account> acclist=[select id,name from account limit 20];
        return acclist;
    }
}