public class CreateZoomLink {
    public static void getLink()
    {
        Http http = new Http();
HttpRequest request = new HttpRequest();
       
request.setEndpoint('https://api.zoom.us/v2/users/me');
 request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('req');
        HttpResponse response = http.send(request);
  if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
       
}
    }