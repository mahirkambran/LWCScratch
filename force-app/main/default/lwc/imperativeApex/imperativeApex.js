import contactFetcher from '@salesforce/apex/AccountParaExample.contactFetcher';
import { LightningElement } from 'lwc';

export default class ImperativeApex extends LightningElement {

    searchedText;
    contacts;

    handleContactSearch(event){
        this.searchedText = event.target.value;
    }

    contactSearchEvent(event){
        contactFetcher({contactName:this.searchedText})
        .then(result =>{
            this.contacts = result;
        })
        .catch(error =>{
            console.log(error);
        });
    }
}