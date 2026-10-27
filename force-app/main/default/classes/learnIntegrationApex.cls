public class learnIntegrationApex {
    public static void makeCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.spoonacular.com/recipes/random?apiKey=331f385e64f6403a9e289a495b84cc59');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        System.debug(response.getbody());
        
        if(response.getStatusCode() == 200){
            System.debug('Made a callout to external system');
            System.debug(response.getbody());
        }
    }
}