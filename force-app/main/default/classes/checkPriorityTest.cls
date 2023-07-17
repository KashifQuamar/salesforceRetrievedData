@isTest
public class checkPriorityTest {
    @isTest
    static void sendData1()
    {
         string result=checkPriority.getPriority('CPR');
        system.assertEquals(Null, result, 'this is what i expected');
    }
   
 @isTest
    static void sendData2()
    {
         string result=checkPriority.getPriority('CR');
        system.assertEquals('NORMAL', result, 'this is what i expected');
    }
    @isTest
    static void sendData3()
    {
         string result=checkPriority.getPriority('CA');
        system.assertEquals('HIGH', result, 'this is what i expected');
    }
   
}