import { LightningElement,api,track,wire } from 'lwc';
import deletecontact from'@salesforce/apex/infiniteScrolling.delcon';
import getContacts from'@salesforce/apex/infiniteScrolling.getConData';
import { refreshApex } from '@salesforce/apex';
var actions = [
    {label: 'View', name: 'view'},
    {label: 'Edit', name: 'edit'},
    {label: 'Delete', name: 'delete'}
];

const columns = [
    {
    label:"Name", fieldName : 'Name',sortable: "true"},
    {label:"playerrecordid",fieldName : 'Id',sortable: "true"},
    {label:'Account Name',fieldName:'Account.Name',sortable: "true"},
   {label:'Email',fieldName:'Email',sortable: "true"},
   {type: 'action', typeAttributes: { rowActions: actions } } 
   
];

export default class InfiniteScrolling extends LightningElement {
       
    @api search;
    @track columns = columns;
    @track data = [];
    accounts=[];
    @track sortBy;
    @track sortDirection;
    error;
    limitt=10;
    offsett=0;
    samar=[];
 
   currentpage=1;
   recordsize;
   recordamount=10;
  
    @track wiredAccountList = [];
   
   
    connectedCallback() {
        this.showData();
    }

   
    handleOnClick(){
        var inp=this.template.querySelectorAll("lightning-input");
        inp.forEach(function(element){
            if(element.name=="search"){
                this.search=element.value;
              
            }
        },this);
       
       var  l=this.samar.length;
        var first=this.search.toUpperCase();
       
       var searchresult=[];
       if(first.length>0){
        for(let i=0;i<l;i++)
        { 
            var q= this.samar[i].Name;
           var e=this.samar[i].Email;
          
          
            var second=q.toUpperCase();
          
            if(e!='' && e!=null && e!=undefined){
              
                var f=e.toUpperCase();
             if(f.match(first))
            {
                searchresult.push(this.samar[i]);
            }
            else if(second.match(first))
        {
          
          
            searchresult.push(this.samar[i]);
        }
           
        }
        else if(second.match(first))
        {
            searchresult.push(this.samar[i]);
        }
        
        }
    }
        console.log('this is search');
        console.log(searchresult);
        console.log('search lenth='+searchresult.length);
        if(searchresult.length>0)
        {
           
             this.accounts=searchresult;
        }
       
     
   
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
                deletecontact({c:row.Id})
                .then(()=>{
                     refreshApex(this.wiredAccountList);
                }).catch(error=>{
                    console.log('error occured');
                    console.log(error);
                });
                
                alert('item is deleted');
                
               
                break;
                case 'edit':
                    const roww = this.data;
                    alert('Showing Details: ' + JSON.stringify(row));
                    break;
   }
    }
   
    handleOnOption(event){
   
   
   
   this.recordamount=event.target.value;
   this.limitt=event.target.value;
   
  alert(this.limitt);
   
   }
   showData(){
    return  getContacts({ no_of_limit: this.limitt , offsetlimit : this.offsett })
    .then(result => {
        let updatedRecords = [...this.accounts, ...result];
        this.accounts = updatedRecords;
        this.samar=this.accounts;
        // console.log(this.samar);
        // console.log(this.accounts[0]);
        this.error = undefined;
    })
    .catch(error => {
        this.error = error;
        this.accounts = undefined;
    });
}
loadMoreData(event) {
 

    this.offsett = this.offsett + this.limitt;
    console.log('offset=>'+this.offsett);
    this.showData()
        // .then(()=> {
        //     target.isLoading = false;
        // });   
}
doSorting(event) {
    console.log('event=');
    console.log(event.detail.fieldName);
    this.sortBy = event.detail.fieldName;
    this.sortDirection=event.detail.direction;
    console.log('do sorting');
    console.log('sort direction=>'+this.sortDirection);
    console.log('sortby=>'+this.sortBy);
    this.sortData(this.sortBy, this.sortDirection);
}

sortData(fieldname, direction) {
    let parseData = JSON.parse(JSON.stringify(this.accounts));
    console.log('parse data');
    console.log(parseData);
    console.log('fieldname'+fieldname);
    let keyValue = (a) => {
        return a[fieldname];
    };
   
    // cheking reverse direction
    let isReverse = direction === 'asc' ? 1: -1;
   
    // sorting data
    parseData.sort((x, y) => {
        x = keyValue(x) ? keyValue(x) : ''; // handling null values
        y = keyValue(y) ? keyValue(y) : '';
        console.log('x>y');
        console.log(x>y);
        console.log('y>x');
        console.log(y>x);
        console.log((x > y) - (y > x));
        return isReverse * ((x > y) - (y > x));
    });
    console.log('sorted data');
console.log(parseData);

    this.accounts = parseData;
}    
       
}