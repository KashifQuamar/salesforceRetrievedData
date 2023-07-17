@istest
public class FutureClassZoomTest {
    @istest
    static void method1(){
         test.setMock(HttpCalloutMock.class, new HttpMockFactory('Content-Type','x-www-form-urlencoded',200));
        list<contact> conlist= new list<contact>();
        for(integer i=0;i<=90;i++)
        {
             contact con=new contact(lastname='Kashif'+i,email='kashif'+i+'@gmail.com');
             conlist.add(con);
        }
       
        insert conlist;
         List<Event>eventList=new List<Event>();
        for(integer i=0;i<=15;i++){
        
        Event e= new event();
        e.subject='Meeting';
        e.whoid=conlist[i].id;
        e.DurationInMinutes=60;
        e.StartDateTime=system.now();
        e.StartDateTime=System.now().addHours(1);
        eventList.add(e); 
        }
       
      //  insert eventList;
      //  system.assertEquals(eventList.size(),91);
      

    }

    @istest
     static void method2(){
        test.setMock(HttpCalloutMock.class, new HttpMockFactory('Content-Type','application/json',201));
        list<contact> conlist= new list<contact>();
        for(integer i=0;i<=90;i++)
        {
             contact con=new contact(lastname='Kashif'+i,email='kashif'+i+'@gmail.com');
             conlist.add(con);
        }
       
        insert conlist;
         List<Event>eventList=new List<Event>();
        for(integer i=0;i<=5;i++){
        
        Event e= new event();
        e.subject='Meeting';
        e.whoid=conlist[i].id;
        e.DurationInMinutes=60;
        e.StartDateTime=system.now();
        e.StartDateTime=System.now().addHours(1);
        eventList.add(e); 
        }
       
       insert eventList;
      // system.assertEquals(eventList.size(),91);
      
    }
}