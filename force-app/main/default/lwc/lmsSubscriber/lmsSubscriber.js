import { LightningElement,wire } from 'lwc';
import { MessageContext,subscribe,unsubscribe } from 'lightning/messageService';
import STATUS_MESSAGE_CHANNEL
    from '@salesforce/messageChannel/LMSStatusMessageChannel__c';


export default class LmsSubscriber extends LightningElement {

    subscription = null;
    messageText;

    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        this.subscription = subscribe(this.messageContext,STATUS_MESSAGE_CHANNEL,(message)=>this.handleMessage(message));
    }

    handleMessage(message){
        this.messageText  = message.message;
    }

    disconnectedCallback(){
        if(this.subscription){
            unsubscribe(this.subscription);
            this.subscription=null;
        }
    }

}