@istest
public class Test_queaueable_Check {
 @isTest
    static void method1()
    {
        list<account> acclist=new list<account>();
        list<contact> conlist=new list<contact>();
        for(integer i=0;i<250;i++)
        {
            Account acc=new Account();
           acc.name='kashif'+i;
            acclist.add(acc);
        }
        insert acclist;
        for(integer i=0;i<250;i++)
        {
            Contact con=new contact();
            con.lastname='Samar'+i;
            con.AccountId=acclist[i].id;
            conlist.add(con);
        }
        insert conlist;
        QueableClass que=new QueableClass(acclist);

         id jobid=System.enqueueJob(que);
    }
}