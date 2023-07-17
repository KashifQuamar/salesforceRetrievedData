trigger ZoomLinkFutureMethod on Event (after insert,after update) {
list<id> eventIds=new list<id>();
  if(trigger.isinsert)
  {
   if(trigger.isafter)
   {
    String jsonString = json.serialize(Trigger.NEW);

     ZoomIntegrationFutureClass.CreateZoomLink(jsonString );
   }
}



}