public class Spoonacular {
    
    private static final String SPOONACULAR_API = 'https://api.spoonacular.com';
    private static final String API_KEY = '331f385e64f6403a9e289a495b84cc59';
    
    public static void getReciepe(String reciepeId){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/'+reciepeId+'/information?apiKey='+API_KEY);
		request.setMethod('GET');

		HttpResponse response = http.send(request);
		System.debug('Response Code : '+response.getStatusCode());
		if(response.getStatusCode() == 200){
    		System.debug('response : '+response.getBody());
		}
    }
    
    public static String getRandomReciepe(){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(SPOONACULAR_API+'/recipes/random?apiKey='+API_KEY);
		request.setMethod('GET');

		HttpResponse response = http.send(request);
		if(response.getStatusCode() == 200){
    		return response.getBody();
		}
        return '';
    }
    
    public static String getRandomReciepeByIngredient(String ingredients){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(SPOONACULAR_API+'/recipes/findByIngredients?apiKey='+API_KEY+'&ingredients='+ingredients);
		request.setMethod('GET');

		HttpResponse response = http.send(request);
		if(response.getStatusCode() == 200){
    		return response.getBody();
		}
        return '';
    }
}