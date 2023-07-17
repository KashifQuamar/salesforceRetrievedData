import { LightningElement } from 'lwc';
import account from '@salesforce/schema/Opportunity';
import name from '@salesforce/schema/Opportunity.Name';
import phone from '@salesforce/schema/Opportunity.CloseDate';
import shippingAddress from '@salesforce/schema/Opportunity.CloseDate';
import industry from '@salesforce/schema/Account.Type';

export default class LDS_Page_layout extends LightningElement {
    ObjectApiName=account;
    recordId='0012w00001b0hCkAAI';
    fields=[name,phone,shippingAddress,industry];
}