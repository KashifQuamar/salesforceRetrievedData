import { LightningElement,wire } from 'lwc';
import getMetaData  from'@salesforce/apex/firstVSCodeApexClass.getdata';
export default class GetMetaData extends LightningElement {
    @wire(getMetaData) metadatas;
}