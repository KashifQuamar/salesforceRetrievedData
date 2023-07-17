import { LightningElement,api } from 'lwc';

export default class ComponentEventChild extends LightningElement {
    @api myname;

    handleX()
    {
  console.log('hello world');
   const childevent= new CustomEvent('aman', {
    detail: {firstparam:'first value aman',
              secondparam:'second name jani'}
   
   });
   this.dispatchEvent(childevent);
    }
}