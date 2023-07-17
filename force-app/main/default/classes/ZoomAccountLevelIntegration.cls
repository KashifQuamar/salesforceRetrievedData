global class ZoomAccountLevelIntegration implements Database.Batchable<sObject>, Database.AllowsCallouts,Database.Stateful,Schedulable {
    list<event> eventlist=new list<event>();
    list<id> eventids=new list<id>();
    list<errorobject__c> errorObjectList=new list<errorObject__c>();
    map<id,SObject> Contact_Lead_IdToMap = new map<id,Sobject>();
    list<event>AllEventData= new list<event>();
    set<id> successful_eventids=new set<id>();
     
    // constructor 
    global ZoomAccountLevelIntegration(list<event> eventData){
      AllEventData.addAll(eventData);
       
        
    }
    
    // start method
    global list<event> start(Database.BatchableContext bc) {
       
        Set<Id> whoids = new Set<Id>();
      
        for (Event event :  AllEventData) {
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
       
        return  AllEventData ;
    }
  
    global void execute(Database.BatchableContext bc, List<event> eventData) {
      
        for (event obj : eventData) {
         createZoomMeeting(obj);
        }
        system.debug(eventlist);
        
         if( errorObjectList.size()>0)
        {
            insert errorObjectList;
            system.debug(errorObjectList);
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
    }
    
    
    
    private void createZoomMeeting(event obj) {
        
        list<HttpRequest> requestList=new list<HttpRequest>(); 
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:NamedCredentialZoomAccountLavelApp');
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
          /////////////////////////
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
    
   
    global void finish(Database.BatchableContext bc) {
        list<id> con_lead_ids=new list<id>();
        for(event e:eventlist)
        {
            if(successful_eventids.contains(e.id))
            {
             con_lead_ids.add(e.whoid);   
            }
        }
if(con_lead_ids.size()>0){
    EmailTemplate et = [select id,name from EmailTemplate where developername='ZoomLinkTemplate1'][0]; 
     system.debug('et=='+et);
     system.debug('et=='+et.name);
     Messaging.MassEmailMessage  email = new Messaging.MassEmailMessage ();
     
    email.setTargetObjectIds(con_lead_ids); 
    email.setTemplateId(et.id);
   
    List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(new List<Messaging.MassEmailMessage>{email});


    }
    }
   global void execute(SchedulableCOntext txt) { 
        Id batchJobId = Database.executeBatch(new ZoomAccountLevelIntegration(AllEventData),70);
    
       AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors
                    FROM AsyncApexJob WHERE ID =: batchJobId ];
        System.debug('Job Id: ' + batchJobid + ' Status: ' + aaj.Status);
        system.debug('Number of errors= '+aaj.NumberOfErrors);
   }
}