import AccountFetcher from '@salesforce/apex/AccountFetcher.AccountFetcher';
import { LightningElement, wire } from 'lwc';

export default class Wire extends LightningElement {

    accounts

    @wire(AccountFetcher)
    accountfetch({data,error}){
        if(data){
            this.accounts = data;
        }
        else if(error){
            console.log(error);
        }
    }
}