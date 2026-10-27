import { MessageContext,publish } from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';
import PUBLISH_SUBSCRIBE_MESSAGE_CHANNEL from '@salesforce/messageChannel/UserandPhoneMessageChannel__c'

export default class Publisher extends LightningElement {

    userName;
    phone
    

    changeValueEvent(event){
        if(event.target.name == 'userName'){
            this.userName = event.target.value;
            console.log(this.userName)
        }
        else{
            this.phone = event.target.value;
            console.log(this.phone)
        }
    }

    @wire(MessageContext)
    messageContext;

    sendMessageEvent(event){
        
        const message = {

            messageUserName : this.userName,
            messagePhone : this.phone

        }
        publish(this.messageContext,PUBLISH_SUBSCRIBE_MESSAGE_CHANNEL,message);
    }

}