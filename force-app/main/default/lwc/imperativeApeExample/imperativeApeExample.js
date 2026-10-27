import getAccountDetails from '@salesforce/apex/AccountParaExample.getAccountDetails';
import { LightningElement } from 'lwc';

export default class ImperativeApeExample extends LightningElement {

    searchText;
    accountsData;

    handleSearchText(event){
        this.searchText=event.target.value;
    }

    handleButtonClick(){
        getAccountDetails({accountName:this.searchText})
        .then(result => {
            this.accountsData = result;
            console.log(result);
        })
        .catch(error => {
            console.log(error);
        })
    }
}