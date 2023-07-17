@istest
public class TestContactEmail {
 @istest
    static void sendContact()
    {
        list<contact> conlist=new list<contact>();
        for(integer i=0;i<7;i++)
        {
            contact condata=new contact(lastname='kashif'+i,email='kashif'+i+'@gmail.com');
            conlist.add(condata);
        }
        insert conlist;
    }
}