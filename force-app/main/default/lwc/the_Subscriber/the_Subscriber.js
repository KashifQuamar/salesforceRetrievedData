import { LightningElement,wire,track} from 'lwc';
import {subscribe,MessageContext } from "lightning/messageService";
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/Counting_Update__c';
export default class The_Subscriber extends LightningElement {
    @track counter=0;
    @track count=0;
     subscription=null;
    @wire(MessageContext)
     messageContext;
     connectedCallback() {
        console.log('called');
      this.subscribeToMessageChannel();
     }
     subscribeToMessageChannel()
     {
        console.log('called11');
        this.subscription=subscribe(
            this.messageContext,  
            COUNTING_UPDATED_CHANNEL,
            (message)=>this.handleMessage(message)
            );
     }
   
     handleMessage(message){
        console.log('kashif');
        if(message.operator=='add')
        {
            this.counter=this.counter+1
        }
        if(message.operator=='subtract')
        {
            this.counter=this.counter-1;
        }
        if(message.operator=='Multiply')
        {
            this.counter=this.counter*2;
        }
     }
}