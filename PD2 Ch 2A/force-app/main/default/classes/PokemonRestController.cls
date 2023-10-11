@RestResource(urlMapping='/Pokemon__c/*')
global with sharing class PokemonRestController {

    @HttpPost
    global static Id createPokemon(String name, String moves, String abilities) {
        // Create a new Pokemon record
        Pokemon__c newPokemon = new Pokemon__c(
            Name = name,
           	Moves__c= moves,
           	Abilities__c= abilities
        );
        insert newPokemon;

        return newPokemon.Id;
    }
    
       
    
    
     @HttpGet
    global static Pokemon__c pokemonGet() {
        RestRequest req = RestContext.request;
        String pokemonId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        //String PokemonId ='a00Hs000018e9JYIAY';
        
        Pokemon__c pokemon = [SELECT Id, Name,Moves__c, Abilities__c FROM Pokemon__c WHERE Id = :pokemonId LIMIT 1];
        return pokemon;
    }
}