import { LightningElement, wire, api } from 'lwc';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class LDS_WIRE_Update extends LightningElement {
    @api recordId;
    accountName;
    accountPhone;

    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD, ACCOUNT_PHONE_FIELD] })
    wiredAccount({ error, data }) {
        if (data) {
            this.accountName = data.fields.Name.value;
            this.accountPhone = data.fields.Phone.value;
        } else if (error) {
            console.error('Error retrieving record:', error);
        }
    }

    handleNameChange(event) {
        this.accountName = event.target.value;
    }

    handlePhoneChange(event) {
        this.accountPhone = event.target.value;
    }

    handleSave() {
        const fields = {};
        fields.Id = this.recordId;
        fields[ACCOUNT_NAME_FIELD.fieldApiName] = this.accountName;
        fields[ACCOUNT_PHONE_FIELD.fieldApiName] = this.accountPhone;

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                console.log('Record updated successfully');
                
            })
            .catch((error) => {
                console.error('Error updating record:', error);
              
            });
    }
}