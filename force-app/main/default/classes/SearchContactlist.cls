public class SearchContactlist {
    @AuraEnabled
public static list<contact> getContactData()
{
    list<contact> conlist =[select id ,name from contact];
    return conlist;
}
    @AuraEnabled
    public static list<contact> getSearchedContact(id conid)
    {
        return [select id ,firstname,lastname,email from contact where id=:conid];
    }
}