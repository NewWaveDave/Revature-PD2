import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
    @track userInput = 'pikachu';

    handleInputChange(event) {
        this.userInput = event.target.value;

    }



}
