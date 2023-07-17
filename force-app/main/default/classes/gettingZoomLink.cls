public class gettingZoomLink {
   // Zoom API base URL
    private static final String ZOOM_API_BASE_URL = 'https://api.zoom.us/v2';

    // Zoom API access token
   // private static final String ZOOM_API_ACCESS_TOKEN = '<your_zoom_access_token>';

    // Create a Zoom meeting
    public static void createZoomMeeting(String topic, DateTime startDateTime, Integer durationMinutes,string ZOOM_API_ACCESS_TOKEN) {
      // ZOOM_API_ACCESS_TOKEN='<'+ZOOM_API_ACCESS_TOKEN+'>';
        String endpoint ='https://api.zoom.us/v2/users/me/meetings';

    
        Map<String, Object> requestBody = new Map<String, Object>();
        requestBody.put('topic', topic);
        requestBody.put('type', '2'); // Scheduled meeting type
        requestBody.put('start_time', startDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\''));
        requestBody.put('duration', durationMinutes);

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', 'Bearer ' +ZOOM_API_ACCESS_TOKEN);
        request.setBody(JSON.serialize(requestBody));

        // Send the request
        HttpResponse response = new Http().send(request);

        if (response.getStatusCode() == 201) {
            // Zoom meeting created successfully
            system.debug(response.getBody());
            Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            String meetingId = (String) responseData.get('id');
            
            
            saveZoomMeetingDetails(meetingId);
        } else {
           
            System.debug('Zoom API request failed with status code: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
          
        }
    }

  
    private static void saveZoomMeetingDetails(String meetingId) {
      system.debug(meetingId);
    }
    
    
    
    public static void getToken(){
       
        Http http = new Http();
HttpRequest request = new HttpRequest();
      
//request.setEndpoint('https://zoom.us/oauth/authorize?client_id=y8hU9xsTHuoNQ_9FS41Ew&redirect_uri=https://grazittiinteractive-21c-dev-ed.develop.my.salesforce.com&response_type=code');
request.setEndpoint('https://zoom.us/oauth/authorize?client_id=y8hU9xsTHuoNQ_9FS41Ew&response_type=code&redirect_uri=https%3A%2F%2Fgrazittiinteractive-21c-dev-ed.develop.lightning.force.com');
        request.setMethod('POST');
       //application/x-www-form-urlencoded
       //application/json
       //https://MyDomainName.my.salesforce.com/services/oauth2/authorize?
//client_id=3MVG9IHf89I1t8hrvswazsWedXWY0i1qK20PSFaInvUgLFB6vrcb9bbWFTSIHpO8G2jxBLJA6uZGyPFC5Aejq&
//redirect_uri=https://www.mycustomerorderstatus.com/oauth2/callback&
//response_type=code
        request.setHeader('Content-Type','application/json');
        String CLIENT_ID = 'y8hU9xsTHuoNQ_9FS41Ew';
       String CLIENT_SECRET = 'vW5TgoawWyoobdskS8Eo8NKDYdVnceJb';
        string user_name='kashif.quamar@grazitti.com';
        string password='Kashifsamar786@';
        //+'&access_token=token'
//request.setBody('grant_type=password' + '&client_id='+CLIENT_ID + '&client_secret='+CLIENT_SECRET +'&username='+user_name+ '&password='+password+ '&scope=meeting:write:admin' );
  request.setBody('grant_type=authorization_code' + '&client_id='+CLIENT_ID + '&client_secret='+CLIENT_SECRET + '&scope=meeting:write:admin');
      
HttpResponse response = http.send(request);
      system.debug(response.getBody());
 system.debug(response);        
          //system.debug(JSON.serialize(request.getBody()));
        //system.debug(JSON.deserializeUntyped(response.getBody()));
 
// Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
//String token = '';
//String refreshtoken = '';
//if(response.getStatusCode() == 200){
 //token = (String)results.get('access_token');
  //  system.debug(token);
   
 //refreshtoken = (String)results.get('refresh_token');
//}
        
    }
    public static void getCalenderData(  string topic,datetime start_time,integer duration)
    {
        string token='eyJzdiI6IjAwMDAwMSIsImFsZyI6IkhTNTEyIiwidiI6IjIuMCIsImtpZCI6IjY2NTdlZmM5LWExOWEtNDdmYi05YTcxLWZlNzVjZTA0NThjNSJ9.eyJ2ZXIiOjksImF1aWQiOiJkZjcyMzA2NjE5MjlkOGJiOWViZDM2NGMyN2UwN2QzNCIsImNvZGUiOiJxQjgxSlVHdnVrWFFtMnRzazN2UzhTbTFTZ0FmdjhRTWciLCJpc3MiOiJ6bTpjaWQ6RWZOeXU3UzN5NTAyaUxBQ0RMR2ciLCJnbm8iOjAsInR5cGUiOjAsInRpZCI6MCwiYXVkIjoiaHR0cHM6Ly9vYXV0aC56b29tLnVzIiwidWlkIjoiUnhEamtQVnlRS3VQbmFyaGI1c2hPUSIsIm5iZiI6MTY4NTUyNTA3MSwiZXhwIjoxNjg1NTI4NjcxLCJpYXQiOjE2ODU1MjUwNzEsImFpZCI6IkVHZzV3b0ZZUmRlVXdfZkhuOHUtdEEifQ.FR68E5-FPq1x3cJO4lypZ5ow3tLnxi0VQQMLhVjbY4l-kYpMkNq0hkl4_AF8J7-rADxYGMXWZRl1nBVslizg9g';
        system.debug(token);
       createZoomMeeting(topic,start_time,duration,token);
        
    }

}

//String data = '2023-01-03T00:26:01.711-02:00';
//Datetime dt = (DateTime)JSON.deserialize('"' + data + '"', DateTime.class);
//gettingZoomLink.getCalenderData('kashif',dt,60);
//gettingZoomLink.getToken();