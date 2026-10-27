public class ApexRestCalloutDemo {
    public static void getUsersFromExternalSystem(){
        
        //GET Users
        
        /*Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://reqres.in/api/users');
        request.setHeader('Content-Type','application/json');
        request.setMethod('GET');
        //request.setBody('');
        
        HttpResponse response = new HttpResponse();
        response = http.send(request);
        
        System.debug('Response Body - - '+ response.getBody());
        
		*/
        
        //POST Users
        
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://reqres.in/api/users');
        request.setHeader('Content-Type','application/json');
        request.setMethod('POST');
        request.setBody('{"name": "morpheus","job": "leader"}');
        
		HttpResponse response = new HttpResponse();
        response = http.send(request);
        
        System.debug('Response Body - - '+ response.getBody());
    }    
}