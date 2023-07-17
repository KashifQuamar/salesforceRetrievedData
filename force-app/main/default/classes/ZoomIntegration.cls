public class ZoomIntegration {

    public static void createZoomMeeting(String topic, DateTime startDateTime, Integer durationMinutes) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:NamedCredentialNewLegacyZoomApi');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
      
        request.setBody('{"topic":"'+ topic + '","type":2,"start_time":"' + startDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\'') + '","duration":' + durationMinutes + '}');
        //request.setBody('{}'); 
        HttpResponse response = new Http().send(request);
         system.debug(response);
        System.debug('Response body: ' + response.getBody());
        
        if (response.getStatusCode() == 201) {
            // Zoom meeting created successfully
           Map<String, Object>  responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
             String meetingId = (String) responseData.get('join_url');
            
            // Save Zoom meeting details or perform other desired operations
            saveZoomMeetingDetails(meetingId);
        } else {
            // Zoom API request failed
            System.debug('Zoom API request failed with status code: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
        }
    }

    private static void saveZoomMeetingDetails(String meetingId) {
        // Implement your logic to save Zoom meeting details in Salesforce
        System.debug('Zoom meeting ID: ' + meetingId);
    }

}