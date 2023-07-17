import { LightningElement,wire,track } from 'lwc';
import { subscribe,MessageContext,publish} from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/InputMessage__c";
export default class Self_LWC_To_receiveFromVFpage extends LightningElement {
    @track receivedMessage;
    @track sendMessage;
    subscription=null;
    @wire(MessageContext)
     messageContext;
     connectedCallback() {
        console.log('called');
      this.subscribeToMessageChannel();
     }
     subscribeToMessageChannel()
     {
        console.log('this is from lwc-------------------------------');
        this.subscription=subscribe(
            this.messageContext,  
            SAMPLEMC,
            (message)=>this.handleMessage(message)
            );
     }
     handleInputChange(event)
     {
        const inputValue = event.target.value;
        console.log(inputValue);
        this.sendMessage=inputValue;
     }
     handleMessage(message){
        console.log('kashif');
        this.receivedMessage=message.inputMessage;
       
    }
    messagePass()
    {
        console.log('hello');
       console.log(this.sendMessage);
      const data={
        inputMessage2:this.sendMessage
      }  
     
      console.log(data);
      console.log('this is lower section');
      console.log(this.messageContext);
      publish(this.messageContext,SAMPLEMC,data);
    }
   
    

}