import { MessageContext, subscribe ,unsubscribe} from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';
import PUBLISH_SUBSCRIBE_MESSAGE_CHANNEL from '@salesforce/messageChannel/UserandPhoneMessageChannel__c';

export default class Subscriber extends LightningElement {

    subscription = null;
    userName;
    phone;

    @wire(MessageContext)
    messageContext

    connectedCallback(){
        this.subscription = subscribe(this.messageContext,PUBLISH_SUBSCRIBE_MESSAGE_CHANNEL,(message)=>this.handleMessage(message));
    }

    handleMessage(message){
        this.userName = message.messageUserName
        this.phone = message.messagePhone
    }

    disconnectedCallback(){
            if(this.subscription){
                unsubscribe(this.subscription);
                this.subscription=null;
            }
        }
}