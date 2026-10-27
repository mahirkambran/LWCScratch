import { LightningElement, wire } from 'lwc';
import { MessageContext,publish } from 'lightning/messageService';
import STATUS_MESSAGE_CHANNEL
    from '@salesforce/messageChannel/LMSStatusMessageChannel__c';
export default class LmsPublisher extends LightningElement {

    messageText;

    ChangeMessageEvent(event){
        this.messageText = event.target.value;
    }

    @wire(MessageContext)
    messageContext;

    handleMessageEvent(event){

        const message = {
            message : this.messageText
        }

        publish(this.messageContext,STATUS_MESSAGE_CHANNEL,message)
    }
}