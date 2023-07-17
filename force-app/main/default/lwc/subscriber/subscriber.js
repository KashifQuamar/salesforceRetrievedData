import { LightningElement,wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener,unregisterAllListner } from 'c/pubSub';

export default class Subscriber extends LightningElement {
    strCaptureText=''
    @wire(CurrentPageReference)
    pageRef;
    connectedCallback(){
        registerListener('aman',this.xyz,this);
    }
    xyz(namer){
        console.log('this is namer');
   console.log(namer);
   this.strCaptureText=namer;
    }
    disconnectedCallback(){
        unregisterAllListner(this);
    }
}