@isTest
public class PokemonCalloutTest {

    // Mock HTTP callout response
    public class MockHttpResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
          
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(201);
            res.setBody('{"success": true}');
            return res;
        }
    }

    @isTest
    static void testCreatePokemon() {
        
        
        Pokemon newPokemon = new Pokemon();
		newPokemon.name = 'Squirtle';
		newPokemon.moves = 'mega-punch';
		newPokemon.abilities = 'rain-dish';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        PokemonCallout.createPokemon(newPokemon);

        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:PokemonCred/service/apexrest/Pokemon__c');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        String expectedRequestBody = JSON.serialize(newPokemon);
       // System.assertEquals(expectedRequestBody, request.getBody());

        HttpResponse response = new Http().send(request);
        System.assertEquals(201, response.getStatusCode());
        System.assertEquals('{"success": true}', response.getBody());
    }
     
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake HTTP response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"name": "Pikachu"}');
            res.setStatusCode(200);
            return res;
        }
    }
    @isTest
    public static void testGetPokemonInfo() {
       
        String pokemonId = 'a00Hs000018e9JYIAY';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
       //PokemonCallout.getPokemonInfo(pokemonId);
		
        HttpResponse res = PokemonCallout.getPokemonInfo(pokemonId);
        
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"name": "Pikachu"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
        
        


    }
}