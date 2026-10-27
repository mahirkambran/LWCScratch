import { LightningElement } from 'lwc';

export default class CustomEventParent extends LightningElement {

    userName;

    handleCustomEventParent(event){
        this.userName = event.detail.firstName;
    }
}