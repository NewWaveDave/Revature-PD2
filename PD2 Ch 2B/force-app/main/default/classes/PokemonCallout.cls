public class PokemonCallout {

//post    
    public static void createPokemon(Pokemon pokemon) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:PokemonCred/services/apexrest/Pokemon__c');
        request.setMethod('POST');
        
        
        String requestBody = JSON.serialize(pokemon);
        request.setBody(requestBody);
        
		request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        request.setHeader('Content-Type', 'json/application');
        
        Http http = new Http();
        System.debug(requestBody);
        HttpResponse response = http.send(request); 
        System.debug(response.getHeader('Location'));
        
        if (response.getStatusCode() == 200) {
            
            System.debug(response.getBody());
        } else{
            System.debug(response.getStatus());
            System.debug(response.getStatusCode());
            
        }
    }
  // get
        public static HttpResponse getPokemonInfo(String pokemonId) {
        String endpoint = 'callout:PokemonCred/services/apexrest/Pokemon__c';
        
        HttpRequest request = new HttpRequest();
        //request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
      	request.setHeader('Content-Type', 'json/application');
        String apiUrl = endpoint  +'/'+ pokemonId;
        request.setEndpoint(apiUrl);   
        HttpResponse response = new Http().send(request);
        System.debug(response.getHeader('Location'));
        if (response.getStatusCode() == 200) {
            System.debug(response);
        } else {
            System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
        }
            return response;
    }
// to run get
//PokemonCallout.getPokemonInfo('ID');
//with test id: 
//PokemonCallout.getPokemonInfo('a00Hs000018e9JYIAY');
    
}