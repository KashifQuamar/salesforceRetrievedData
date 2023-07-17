import { LightningElement ,track} from 'lwc';

export default class ComponentEventParent extends LightningElement {
    @track parentValue='++++_____________--------+++++_______________';
    handleEvent(event){
        alert('custom event fire');
        this.parentValue=event.detail.firstparam;
        alert('second value'+event.detail.secondparam);
    }
}