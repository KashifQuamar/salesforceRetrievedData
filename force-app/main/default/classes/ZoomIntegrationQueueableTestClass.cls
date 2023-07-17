@istest
public class ZoomIntegrationQueueableTestClass {
 @istest
    static void method1(){
         test.setMock(HttpCalloutMock.class, new HttpMockFactory('Content-Type','x-www-form-urlencoded',200));
        list<contact> conlist= new list<contact>();
        for(integer i=0;i<=9;i++)
        {
             contact con=new contact(lastname='Kashif'+i,email='kashif'+i+'@gmail.com');
             conlist.add(con);
        }
       
        insert conlist;
         List<Event>eventList=new List<Event>();
        for(integer i=0;i<=9;i++)
        {
        
        Event e= new event();
        e.subject='Meeting';
        e.whoid=conlist[i].id;
        e.DurationInMinutes=60;
        e.StartDateTime=system.now();
        e.StartDateTime=System.now().addHours(1);
        eventList.add(e); 
        }
       
      test.startTest();
        insert eventList;
        test.stopTest();
      //  system.assertEquals(eventList.size(),91);
      

    }

    @istest
     static void method2(){
        test.setMock(HttpCalloutMock.class, new HttpMockFactory('Content-Type','application/json',201));
        list<contact> conlist= new list<contact>();
        for(integer i=0;i<=4;i++)
        {
             contact con=new contact(lastname='Kashif'+i,email='kashif'+i+'@gmail.com');
             conlist.add(con);
        }
       
        insert conlist;
         List<Event>eventList=new List<Event>();
        for(integer i=0;i<=4;i++)
        {
        
        Event e= new event();
        e.subject='Meeting';
        e.whoid=conlist[i].id;
        e.DurationInMinutes=60;
        e.StartDateTime=system.now();
        e.StartDateTime=System.now().addHours(1);
        eventList.add(e); 
        }
       
      test.startTest();
        insert eventList;
        test.stopTest();
      // system.assertEquals(eventList.size(),91);
      
    }
    
     @istest
    static void method3(){
         test.setMock(HttpCalloutMock.class, new HttpMockFactory('Content-Type','application/json',201));
        list<lead>leadlist=new list<lead>();
        for(integer i=0;i<=2;i++)
        {
            lead leadData=new lead(lastname='kashiff'+i,Company='Grazitti'+i,status='Open-Not Contacted',occupation__c='Doctor',email='Umar'+i+'@gmail.com');
            leadlist.add(leadData);
        }
       
        insert leadlist;
         List<Event>eventList=new List<Event>();
        for(integer i=0;i<=2;i++)
        {
        
        Event e= new event();
        e.subject='Meeting';
        e.whoid=leadlist[i].id;
        e.DurationInMinutes=60;
        e.StartDateTime=system.now();
        e.StartDateTime=System.now().addHours(1);
        eventList.add(e); 
        }
       test.startTest();
        insert eventList;
        test.stopTest();
      //  system.assertEquals(eventList.size(),91);
      

    }

}