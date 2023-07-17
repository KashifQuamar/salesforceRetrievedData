import { LightningElement ,api,wire} from 'lwc';
import  { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubSub';

export default class Publisher extends LightningElement {
    @wire(CurrentPageReference) pageRef;
     strText=''
    handleChange(event){
   this.strText= event.target.value;

   
    }
    publishEvent(){
    fireEvent(this.pageRef,'aman',this.strText)
    }
}