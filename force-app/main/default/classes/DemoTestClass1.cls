@isTest
public class DemoTestClass1 {
    @testsetup static void setup(){
       list<account> acclist=new list<account>();
        for(integer i=0;i<200;i++)
        {
            acclist.add(new account(Name='kashif'+i,Industry='Education',Rating='Hot',Phone='748-407'+i));
        }
        system.debug(acclist);
        insert acclist;
    }
    @isTest
    static void myTest1(){
        account acc=[select id from account where name='kashif0' limit 1];
        acc.phone='995-5460';
        update acc;
        
         account acc1=[select id from account where name='kashif1' limit 1];
        delete acc1;
        
    }
    @isTest
    static void myTest2(){
      account acc=[select phone from account where name='kashif0' limit 1];
        system.debug(acc);
        System.assertEquals('748-4070',acc.phone);
       
         account acc2=[select id from account where name='kashif1' limit 1];
        system.debug(acc2);
         system.assertNotEquals(null, acc2);
        
    }
    @isTest
    static void myTest3(){
        
        
    }
    @isTest
    static void myTest4(){
        
    }
}