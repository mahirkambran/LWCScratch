import AccountParaExample from '@salesforce/apex/AccountParaExample.AccountParaExample';
import { LightningElement, wire } from 'lwc';

export default class WireWithParameterExample extends LightningElement {

    accounts;
    searchedText;

    handleSearchText(event){
        this.searchedText = event.target.value;
    }


    @wire(AccountParaExample,{accountName:'$searchedText'})
    accountsData({data,error}){
        if(data){
            this.accounts=data;
        }
        else{
            console.log(error);
        }
    }
}