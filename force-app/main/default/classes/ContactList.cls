public class ContactList {
    @AuraEnabled
  public static list<contact> getContacts(id recordId)
  {
      list<contact> conlist=[select id,firstname,lastname,email from contact where accountid=:recordId];
      return conlist;
  }
}