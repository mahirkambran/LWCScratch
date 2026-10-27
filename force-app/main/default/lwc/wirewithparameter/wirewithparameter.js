import AccountFetcherWithParameter from '@salesforce/apex/AccountFetcherWithParameter.AccountFetcherWithParameter';
import { LightningElement, wire } from 'lwc';

export default class Wirewithparameter extends LightningElement {

    accounts
    accountSearchText

    nameChangeEvent(event){
        this.accountSearchText = event.target.value;
    }

    @wire(AccountFetcherWithParameter,{accountName:'$accountSearchText'})
    accountfetcher({data,error}){
        if(data){
            this.accounts = data;
        }
        else{
            console.log(error);
        }
    }
}