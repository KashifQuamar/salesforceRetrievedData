global class CreateZoomMeetingBatch implements Database.Batchable<sObject>, Database.AllowsCallouts,Database.Stateful {
     list<event> eventlist=new list<event>();
    list<id> eventids=new list<id>();
    map<id,list<string>> eventDataMap=new  map<id,list<string>>();
    
     global string ZoomUrl;
    object MeetingId;
     global CreateZoomMeetingBatch(list<id> eventid){
        eventids.addAll(eventid);
         system.debug(eventids);
        
    }
    global list<event> start(Database.BatchableContext bc) {
    
        list<event> event_QueryData=[SELECT Id,subject, StartDateTime, DurationInMinutes,meeting_link__c,whoid FROM event where id in:eventids];
     
Set<Id> contactIds = new Set<Id>();
for (Event event : event_QueryData) {
    if (event.Whoid.getSObjectType() == Contact.SObjectType) {
        contactIds.add(event.Whoid);
    }
}
system.debug(contactIds);
List<Contact> contacts = [SELECT Id, Name, Email FROM Contact WHERE Id IN :contactIds];

for (Event event : event_QueryData) {
    list<string> contact_data=new list<string>();
    if (event.Whoid.getSObjectType() == Contact.SObjectType) {
        for (Contact contact : contacts) {
            if (contact.Id == event.Whoid) {
               
                contact_data.add(contact.Name);
                if(contact.email!=null)
                {
                    contact_data.add(contact.Email);  
                }
              
                eventDataMap.put(event.id,contact_data);
                break;
            }
        }
    }
  
}
        
        /////////////////////////////
        return event_QueryData ;
    }
    
    global void execute(Database.BatchableContext bc, List<event> scope) {
     for (event obj : scope) {
            String topic = obj.subject;
            DateTime startDateTime = obj.StartDateTime;
            Integer durationMinutes = obj.DurationInMinutes;
            id eventid=obj.id;
           
            createZoomMeeting(topic, startDateTime, durationMinutes,eventid);
        }
    }
    
    
    
    private void createZoomMeeting(String topic, DateTime startDateTime, Integer durationMinutes,id eventid) {
         HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:NamedCredentialNewLegacyZoomApi');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
  
        Map<String, Object> requestBody = new Map<String, Object>();
        requestBody.put('topic', topic);
        requestBody.put('type', '2'); // Scheduled meeting type
        requestBody.put('start_time', startDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\''));
        requestBody.put('duration', durationMinutes);
        requestBody.put('contact_name','kashif quamar');
        requestBody.put('email','kashif.quamar@grazitti.com');
        requestBody.put('schedule_for','kashif.quamar@grazitti.com');
         request.setBody(JSON.serialize(requestBody));

        
      
        HttpResponse response = new Http().send(request);
         system.debug(response);
        System.debug('Response body: ' + response.getBody());
        
        if (response.getStatusCode() == 201) {
            // Zoom meeting created successfully
           Map<String, Object>  responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
             String meetingUrl = (String) responseData.get('join_url');
            system.debug(meetingUrl);
              MeetingId = (object) responseData.get('id');
             system.debug(MeetingId);
               ZoomUrl=meetingUrl;
              system.debug(ZoomUrl);
           
            saveZoomMeetingDetails(meetingUrl,eventid);
        } else {
            // Zoom API request failed
            System.debug('Zoom API request failed with status code: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
        }
          }
    
    private void saveZoomMeetingDetails(String meetingUrl,id eventid) {
     
        System.debug('Zoom meeting ID: ' + meetingUrl);
        System.debug('Event id: ' + eventid);
       event e=new event();
        e.id=eventid;
        e.meeting_link__c=meetingUrl;
          eventlist.add(e);
         // update e;
      
        
        
    }
    global void finish(Database.BatchableContext bc) {
        system.debug('event list');
        system.debug(eventlist);
        system.debug(MeetingId);
         system.debug(ZoomUrl);
         update eventlist;
        system.debug(eventDataMap);
        system.debug(eventDataMap.keySet());
        for(event e:eventlist)
        {
            if(eventDataMap.containskey(e.id)){
                list<string> condata=eventDataMap.get(e.id);
                system.debug(condata);
                system.debug(condata[0]);
             
                system.debug(condata.size());
                if(condata.size()==2)
                {
                  //List<String> participantEmails = new List<String>{condata[1]};
                     List<String> participantEmails =new List<String>();
                    participantEmails.add(condata[1]);
                    system.debug(participantEmails);
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(participantEmails);
                     email.setSubject('Zoom Meeting Notification');
                     email.setPlainTextBody('Dear  '+condata[0] +',\n\nYou have been invited to a Zoom meeting. Please find the meeting details below:\n\nMeeting ID: ' + MeetingId + '\nJoin URL: ' + ZoomUrl + '\n\nThank you.');
                      Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});

                }
            }
        }
      
        
        
        
        
    }
    
}