import fetchOpportunities from '@salesforce/apex/AccountParaExample.fetchOpportunities';
import { LightningElement, wire } from 'lwc';

export default class Wireforashuthosh extends LightningElement {

    opportunity;

    @wire(fetchOpportunities)
    opportunities({data,error}){
        if(data){
            this.opportunity = data;
        }
        else{
            console.log(error);
        }
    }

}