global class ZoomIntegrationFutureClass {
    
    
    @future(callout=true)
    public static void CreateZoomLink(string jsonString){
        
        list<event> eventlist=new list<event>();
        list<errorobject__c> errorObjectList=new list<errorObject__c>();
        map<id,SObject> Contact_Lead_IdToMap = new map<id,Sobject>();
        list<event>AllEventData= new list<event>();
        set<id> successful_eventids=new set<id>();
        Set<Id> whoids = new Set<Id>();
        
        List<event> EventTriggerList = (List<event>)Json.deserialize(jsonString,List<event>.class);        
      
        
        for(event event :EventTriggerList)
        {
            if (event.Whoid.getSObjectType() == Contact.SObjectType || event.whoid.getSObjectType()==lead.SObjectType) {
                whoids.add(event.Whoid);
            }
        }
        
        if(whoids.size()>0){
            for(contact con: [SELECT Id, Name, Email FROM Contact WHERE Id IN :whoids AND email!=null ])
            {
                Contact_Lead_IdToMap.put(con.id,con);
                
            }
            
            for(lead leadData: [SELECT Id, Name, Email FROM lead WHERE Id IN :whoids and email!=null])
            {
                Contact_Lead_IdToMap.put(leaddata.id,leaddata);
                
            }
            
        }
        // generating zoom link
        for(event obj:EventTriggerList)
        {
            list<HttpRequest> requestList=new list<HttpRequest>(); 
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:FutureMethodZoom');
            //request.setEndpoint('https://api.zoom.us/v2/users/me/meetings');
            request.setMethod('POST');
            
            request.setHeader('Content-Type', 'application/json');
            
            Map<String, Object> requestBody = new Map<String, Object>();
            requestBody.put('topic', obj.subject);
            requestBody.put('type', '2'); // Scheduled meeting type
            requestBody.put('start_time', obj.startDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\''));
            requestBody.put('duration', obj.DurationInMinutes);
            
            request.setBody(JSON.serialize(requestBody));
            
            HttpResponse response = new Http().send(request);
            if (response.getStatusCode() == 201) {
                // Zoom meeting created successfully
                Map<String, Object>  responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                String ZoomUrl = (String) responseData.get('join_url');
                string MeetingId= string.valueOf(responseData.get('id'));
                
                
                // creating a event object
                event eventObj=new event();
                eventObj.id=obj.id;
                eventObj.meeting_link__c=ZoomUrl;
                eventObj.whoid=obj.WhoId;
                eventObj.Meeting_ID__c=MeetingId;
                eventlist.add(eventObj); 
                
            }
            else{
                Map<String, Object>  responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                errorobject__c errobj=new errorobject__c();
                errobj.Status_code__c=response.getStatusCode();
                errobj.Error_message__c=(string)responseData.get('message');
                errobj.Request_Body_Code__c=(Integer)responseData.get('code');
                errobj.classname__c='ZoomAccountLevelIntegration';
                errobj.Record_Id__c=obj.id;
                errobj.Method_Name__c='createZoomMeeting';
                
                errorObjectList.add(errobj);
                
            }
            
            
        }
        if(eventlist.size()>0)
        {
            Database.SaveResult[] srList = Database.update(eventlist, false);
            system.debug(srlist);
            system.debug(eventlist);
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    
                    
                    successful_eventids.add(sr.getId());
                }
                if (!sr.isSuccess() || Test.isRunningTest()) {    
                    for(Database.Error err : sr.getErrors()) {
                        errorobject__c errData=new errorobject__c();
                        errdata.Status_code__c=Integer.valueOf(err.getStatusCode());
                        errdata.Error_message__c=err.getMessage();
                        errdata.classname__c='ZoomAccountLevelIntegration';
                        errdata.Record_Id__c=sr.getId();
                        errdata.Method_Name__c='finish';
                        errorObjectList.add(errdata);
                    }
                }
            }
        }
        //////////////////////
        
        List<Messaging.SingleEmailMessage> emaillist=new  List<Messaging.SingleEmailMessage>();
        
        system.debug(eventlist);
        for(event e:eventlist)
        {
            if(successful_eventids.contains(e.id) && Contact_Lead_IdToMap.containskey(e.whoid)){
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject('Zoom Meeting Notification');
                
                set<string> participantEmails =new set<string>();
                if(e.Whoid.getSObjectType() == Contact.SObjectType){
                    contact conData=(contact) Contact_Lead_IdToMap.get(e.whoid);
                    participantEmails.add(condata.email);
                    email.setPlainTextBody('Dear  '+condata.name +',\n\nYou have been invited to a Zoom meeting. Please find the meeting details below:\n\nMeeting ID: ' + e.Meeting_ID__c + '\nJoin URL: ' + e.Meeting_Link__c + '\n\nThank you.');
                    
                } 
                else if(e.whoid.getSObjectType()==Lead.SObjectType)
                {
                    lead leadData=(lead)Contact_Lead_IdToMap.get(e.whoid);
                    participantEmails.add(leadData.email);
                    email.setPlainTextBody('Dear  '+leadData.name +',\n\nYou have been invited to a Zoom meeting. Please find the meeting details below:\n\nMeeting ID: ' + e.Meeting_ID__c + '\nJoin URL: ' + e.Meeting_Link__c + '\n\nThank you.');
                    
                }
                list<string> AllMail=new list<string>();
                system.debug(participantEmails);
                AllMail.addAll(participantEmails);
                email.setToAddresses(AllMail);
                emaillist.add(email);
                
                
            }
        }
        system.debug(emaillist.size());
        system.debug(emaillist);
        if(emaillist.size()>0){
            system.debug('hello'+emaillist.size());
            Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(emaillist);  
            
        }
    }
}