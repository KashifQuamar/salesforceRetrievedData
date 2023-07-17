import { LightningElement } from 'lwc';
import myResource from '@salesforce/resourceUrl/Static_Resorse_test1';
import Static_Resorse_test1_Css from '@salesforce/resourceUrl/Static_Resorse_test1_Css';
import { loadStyle } from 'lightning/platformResourceLoader';
export default class Static_Resource_test extends LightningElement {
    connectedCallback(){
        loadStyle(this,Static_Resorse_test1_Css); 
    }
    
      myResource=myResource;
}