@istest
public class CreateZoomLinkTestClass {
   @istest
    static void getLinkmethod1()
    {
        test.setMock(HttpCalloutMock.class, new HttpMockFactory('Content-Type','x-www-form-urlencoded',200));
        
        contact con=new contact(lastname='Kashif',email='kashif@gmail.com');
        insert con;
        
        List<Event>eventList=new List<Event>();
        Event e= new event();
        e.subject='Meeting';
        e.whoid=con.id;
        e.DurationInMinutes=60;
        e.StartDateTime=system.now();
        e.StartDateTime=System.now().addHours(1);
        eventList.add(e);
        insert eventList;
        list<event> eventData=[select id,subject,StartDateTime from event where id=:e.id];
        system.assertEquals(eventData.size(), eventList.size());

    }
    @istest
    static void getLinkmethod2()
    {
           test.setMock(HttpCalloutMock.class, new HttpMockFactory('Content-Type','application/json',201));
     
        contact con=new contact(lastname='Kashif',email='kashif@gmail.com');
        insert con;
        Event e= new event();
        e.subject='Meeting';
        e.whoid=con.id;
        e.DurationInMinutes=60;
        e.StartDateTime=system.now();
        e.StartDateTime=System.now().addHours(1);
        insert e;
        
     
    }
    
    /////
    @istest
    static void getLinkmethod3()
    {
          test.setMock(HttpCalloutMock.class, new HttpMockFactory('Content-Type','application/json',201));
        lead led=new lead(lastname='Kashif',email='kashif@gmail.com',company='grazitti',Occupation__c='Doctor');
        insert led;
        Event e= new event();
        e.subject='Meeting';
        e.whoid=led.id;
        e.DurationInMinutes=60;
        e.StartDateTime=system.now();
        e.StartDateTime=System.now().addHours(1);
        insert e;
    }
}