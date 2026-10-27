public class CallOutFromSF1toSF2 {
    public static void sendCalloutToOrg2(){
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('callout:SecondOrgAccess/services/data/v60.0/sobjects/Account/');
        request.setMethod('POST');
        request.setHeader('Content-type','application/json');
        request.setBody('{"Name":"This is data from Org1"}');
        
        HttpResponse response = new HttpResponse();
        response = http.send(request);
        
        System.debug('Response --->'+response.getBody());
    }
}