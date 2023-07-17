import { LightningElement,api,track,wire} from 'lwc';
import getData from'@salesforce/apex/customDetailsOfObjectss.getdata';
var actions = [
    {label: 'View', name: 'view'},
    {label: 'Edit', name: 'edit'},
    {label: 'Delete', name: 'delete'}
];

var column=[];
export default class CustomDetailOfObjects extends LightningElement {
    @api tableName;
    @api objectApi;
    @api fieldsName;
    @track columns;
    @track sortBy;
    @track sortDirection;
   
    @track data=[];
    @track title;
    connectedCallback() {
    this.showcode();
    }
    showcode(){
        console.log(this.tableName);
        console.log(this.fieldsName);
        
        this.title='All data of '+this.tableName+' are here'
        var keyword=this.fieldsName.toString();
        
        console.log('keyword');
    console.log(keyword);
   var trackname=keyword.split(",");
   console.log('trackname');
   console.log(trackname[0]);
   console.log(trackname.length);
   var l=trackname.length;
   for(var i=0;i<l;i++)
   {
    var c=trackname[i].charAt(0).toUpperCase()+trackname[i].slice(1);
   var ob2={
    type: 'action',typeAttributes: { rowActions: actions }
   }
    var obj={
        label:'',
        fieldName:'',
        sortable:'true',
       
    }
    obj.label=c;
    obj.fieldName=c;
    column.push(obj);
     
   }
 this.columns=column;
    }
  
@wire(getData,{objectApiName: '$objectApi' ,Fields : '$fieldsName' })
wiredContacts({data,error }) 
{
    if(data) 
    {
        this.data=data; 
    }
    else{
        console.log('error');
        console.log(error);
    }
}
doSorting(event) {
    this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
}

sortData(fieldname, direction) {
    let parseData = JSON.parse(JSON.stringify(this.data));
    
    let keyValue = (a) => {
        return a[fieldname];
    };
   
    // cheking reverse direction
    let isReverse = direction === 'asc' ? 1: -1;
   
    // sorting data
    parseData.sort((x, y) => {
        x = keyValue(x) ? keyValue(x) : ''; // handling null values
        y = keyValue(y) ? keyValue(y) : '';
       
        return isReverse * ((x > y) - (y > x));
    });
    console.log('sorted data');
console.log(parseData);

    this.data = parseData;
}    
 
}