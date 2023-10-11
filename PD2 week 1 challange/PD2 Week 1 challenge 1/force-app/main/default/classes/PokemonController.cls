public with sharing class PokemonController {
    public PokemonController() {

    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getPokemonInfo(String pokemonName) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pokemonName);
        req.setMethod('GET');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            return responseMap;
        } else {
            return new Map<String, Object>{'error' => 'Pokemon not found'};
        }
    }
}
