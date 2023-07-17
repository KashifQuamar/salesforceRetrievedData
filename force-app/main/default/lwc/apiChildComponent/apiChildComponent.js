import { LightningElement,api } from 'lwc';

export default class ApiChildComponent extends LightningElement {
    @api tester='hello world';
    
    @api clickbuttonn(parentparamkashif){
        alert('this is child'+parentparamkashif.firstname)
        this.tester= parentparamkashif.firstname;
    }
}