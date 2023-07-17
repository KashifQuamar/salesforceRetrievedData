import { LightningElement,wire,track } from 'lwc';
import getcontactlist from '@salesforce/apex/gettingcontacts.gettingContactfun';
const columns = [
    {
    label:'Name', fieldName : 'Name'},
    {label:"playerrecordid",fieldName : 'Id'},
    
   {label:"Account ID",fieldName:'AccountId'}
   
];


export default class GettingContactValues extends LightningElement {

    @track columns = columns;
    @track data = [];






    @wire(getcontactlist)
  
    testplayers({data, error}){
        if(data){
            this.data=data;
            console.log(data);
        }
        else if(error){
            console.log('error occurred');
        }
    }
   
}