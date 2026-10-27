import { LightningElement } from 'lwc';

export default class CustomEventChild extends LightningElement {

    fName;

    handleNameChange(event){

        this.fName = event.target.value;

    }

    sendNameChange(){
        
        const event = new CustomEvent('sendname',{
            detail: {
                firstName : this.fName
            }
        })

        this.dispatchEvent(event);
    }

}