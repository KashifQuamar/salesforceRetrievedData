import { LightningElement,wire } from 'lwc';
import {publish,MessageContext } from "lightning/messageService";
//import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/Counting_Update__c';
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/Counting_Update__c';
export default class The_publisher extends LightningElement {
    @wire(MessageContext)
    messageContext;

    handleOnPlus(){
     const data={
        operator:'add',
        constant:1
     };
     publish(this.messageContext,COUNTING_UPDATED_CHANNEL,data);
    }
    handleOnMinus(){
        const data={
            operator:'subtract',
            constant:1
         };
         publish(this.messageContext,COUNTING_UPDATED_CHANNEL,data);
    }
    handleOnMultiply(){
        const data={
            operator:'Multiply',
            constant:2
         };
         publish(this.messageContext,COUNTING_UPDATED_CHANNEL,data);
    }
}