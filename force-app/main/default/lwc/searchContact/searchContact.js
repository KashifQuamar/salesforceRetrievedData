import { LightningElement,api,track,wire} from 'lwc';
import deletecontact from'@salesforce/apex/searchContact.deleteresult';
import getContacts from'@salesforce/apex/searchContact.getresult';
import { refreshApex } from '@salesforce/apex';

var actions = [
    {label: 'View', name: 'view'},
    {label: 'Edit', name: 'edit'},
    {label: 'Delete', name: 'delete'}
];
const columns = [
    {
    label:'Name', fieldName : 'Name'},
    {label:"playerrecordid",fieldName : 'Id'},
    
   {label:'Email',fieldName:'Email'},
   {type: 'action', typeAttributes: { rowActions: actions } } 
   
];
export default class SearchContact extends LightningElement {
     @api firstname;
     @api lastname;
     @api emaill;
     @track columns = columns;
     @track data = [];

     @track wiredAccountList = [];
    handleOnClick(){
        
     
      
        var inp=this.template.querySelectorAll("lightning-input");


        inp.forEach(function(element){
            if(element.name=="firstname"){
                this.firstname=element.value;
                console.log('this is firstname');
                console.log(this.firstname);
            }
            

            else if(element.name=="lastname")
            {
                this.lastname=element.value;
                console.log(this.lastname);
            }
            else if(element.name=='email')
            {
                this.emaill=element.value;
                console.log(this.emaill);
            }
          
 
           
       
        },this);
        // this.gettinginfo(this.firstname,this.lastname,this.emaill);
        this.relatedrec();
    }
   
    
    handleRowAction(event)
    {
        const action = event.detail.action;
        const row = event.detail.row;
        switch (action.name) {
            case 'view':
              
                alert('Showing Details: ' + JSON.stringify(row));
               
                break;
            case 'delete':
                const rows = this.data;
               
                alert('Showing Details: ' + JSON.stringify(row));
                console.log('rowid'+row.Id);
                console.log(row);
                deletecontact({d:row.Id})
                .then(()=>{
                    console.log('item is receved');
                    console.log('firstname='+this.firstname);

                    refreshApex(this.wiredAccountList);
                }).catch(error=>{
                    console.log('error occured');
                    console.log(error);
                });
                
                alert('item is deleted');
                
               
                break;
                case 'edit':
                    const roww = this.data;
                    console.log(roww);
                    alert('Showing Details: ' + JSON.stringify(row));
                    break;
 }
    }
   
    @wire(getContacts,{ first_name : '$firstname', 
      last_name : '$lastname', 
      emaill : '$emaill'}) contacts;
          relatedrec(result){
            this.wiredAccountList = result;
           
            
            if (result.data) {
                this.data = result.data;
                
                this.error = undefined;
                console.log('there is error4');
            } else if (result.error) {
                this.error = error;
                this.relatedrecord = undefined;
                console.log('there is an error1');
                this.data=[];
            }
           else{
            console.log('there is an error2');
           }
            
           
          }


}