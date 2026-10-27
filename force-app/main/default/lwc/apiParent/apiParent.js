import { LightningElement } from 'lwc';

export default class ApiParent extends LightningElement {

    lName;

    handleChangeName(event){
        this.lName = event.target.value;
        console.log(this.lName);
    }
}