import { LightningElement } from 'lwc';
import account from '@salesforce/schema/Account';
import name from '@salesforce/schema/Account.Name';
import phone from '@salesforce/schema/Account.Phone';
import shippingAddress from '@salesforce/schema/Account.ShippingAddress';
import industry from '@salesforce/schema/Account.Industry';

export default class LDS extends LightningElement {
    ObjectApiName=account;
    recordId='0012w00001b0hCkAAI';
    fields=[name,phone,shippingAddress,industry];
}