import { LightningElement } from 'lwc';

export default class ApiParentComponent extends LightningElement {
    kashifx='hello world';
    kashif(){
        if(this.kashifx=='hello world')
        {
            this.kashifx='quamar';
        }
        else 
        {
           this.kashifx='hello world';
        }
       
        // this.template.querySelector('c-api-child-component').clickbuttonn();
    }
    handleCall(){
        var xyz= this.template.querySelector('c-api-child-component');
        var abc={
            'firstname':'kashif'
        }

        
        
       xyz.clickbuttonn(abc);
    }
}