@isTest
private class PokemonRestControllerTest {

    @isTest static void testCreatePokemon() {
        // Create test data
        Pokemon__c newPokemon;
        
        //run test
        Test.startTest();
        Id newPokemonId = PokemonRestController.createPokemon('Pikachu',  'Quick Attack', 'Static');
        Test.stopTest();

        // Pokemon record was created
        newPokemon = [SELECT Id, Name FROM Pokemon__c WHERE Id = :newPokemonId];
        System.assertEquals('Pikachu', newPokemon.Name);


    }

    @isTest static void testPokemonGet() {
       
        Pokemon__c testPokemon = new Pokemon__c(Name = 'Charmander');
        insert testPokemon;

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestURI = '/services/apexrest/pokemon/' + testPokemon.Id;
        RestContext.request = request;
        RestContext.response = response;

      //start test
        Test.startTest();       
        Pokemon__c resultPokemon = PokemonRestController.pokemonGet();
        Test.stopTest();

        // returned Pokemon 
        System.assertEquals(testPokemon.Id, resultPokemon.Id);
        System.assertEquals(testPokemon.Name, resultPokemon.Name);
    }
}