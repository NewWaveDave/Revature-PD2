import { LightningElement, api, wire } from 'lwc';
import getPokemonInfo from '@salesforce/apex/PokemonController.getPokemonInfo';
import { refreshApex } from '@salesforce/apex';

export default class PokemonInfo extends LightningElement {
    @api pokemonName;
    pokemonData;
    error;

    @wire(getPokemonInfo, { pokemonName: '$pokemonName' })
    wiredPokemonData({ error, data }) {
        if (data) {
            this.pokemonData = data;
            this.error = undefined;
        } else if (error) {
            this.error = 'Error fetching Pokemon data.';
            this.pokemonData = undefined;
        }
    }

    get abilitiesList() {
        return this.pokemonData.abilities.map(ability => ability.ability.name).join(', ');
    }

    get movesList() {
        return this.pokemonData.moves.map(move => move.move.name).join(', ');
    }

    refreshData() {
        return refreshApex(this.wiredPokemonData);
    }
}
