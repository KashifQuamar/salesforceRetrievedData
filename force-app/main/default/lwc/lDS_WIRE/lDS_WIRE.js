import { LightningElement,wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
export default class LDS_WIRE extends LightningElement {
    recordId = '0012w00001ayL83AAE'; // Replace with a valid Salesforce record Id

    @wire(getRecord, { recordId: '$recordId', fields: ['Account.Name', 'Account.Phone', 'Account.Website'] })
    account;
}