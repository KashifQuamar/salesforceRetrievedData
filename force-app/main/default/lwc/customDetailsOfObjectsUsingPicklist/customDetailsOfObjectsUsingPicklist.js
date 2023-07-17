import { LightningElement,api,wire,track } from 'lwc';
import getData from'@salesforce/apex/customDetailsOfObjectss.getdata';
import getFieldName from'@salesforce/apex/customDetailsOfObjectss.getFieldName';
import { refreshApex } from '@salesforce/apex';
var actions = [
    {label: 'View', name: 'view'},
    {label: 'Edit', name: 'edit'},
    {label: 'Delete', name: 'delete'}
];

var column=[];
export default class CustomDetailsOfObjectsUsingPicklist extends LightningElement {
    @api tableName;
    @api objectApi;
    @api fieldsName;
    @track columns=[];
    @track sortBy;
    @track sortDirection;
    @track listOptions=[];
    @track data=[];
    @track title;
   @track searchtableName;
   @track listSelected = [];
   @track alldata;
   @track sendFields='';
   @track wiredAccountList = [];

    setObjectName(event){
        console.log(event.target.value);
        this.searchtableName=event.target.value;
    }
    @wire (getFieldName, {objectName:'$searchtableName' })
    objectDetails(result){
        console.log('resul--------------------------------');
        console.log(result);
        if(result.data!=undefined)
        {
           
           this.alldata=result.data;
          
            var t=Object.values(result.data);
             t.forEach((item, index) => {
                this.listOptions.push({
                    label: item,
                    value: item
                });
             });
 
        }
    }
    handleChange(event) {
        this.listSelected = event.detail.value;
    }
   
   
    fetchdata(){
        console.log('senfdkennfksndcns');
        console.log(this.sendFields);
       
        for(let i=0;i<this.listSelected.length;i++)
        {
           
            var h=this.listSelected[i];
          
       var m=Object.keys(this.alldata).find(key => this.alldata[key] === h);
       var c=this.sendFields.includes(m);
       if(c!=true){
        var obj={
            label:'',
            fieldName:'',
            sortable:'true'
        } 
        obj.label=h;
        obj.fieldName=Object.keys(this.alldata).find(key => this.alldata[key] === h);
    console.log('object values==========>');
    console.log(obj.label);
    console.log(obj.fieldName);
        column.push(obj);
         if(this.sendFields.length==0)
         {
            this.sendFields=Object.keys(this.alldata).find(key => this.alldata[key] === h)
       
         }
         else{
            this.sendFields=this.sendFields+','+Object.keys(this.alldata).find(key => this.alldata[key] === h)
       
         }
      
        }
          
        }
       this.data=[];
       this.columns=[];
     
       
        

    }
    
  
@wire(getData,{objectApiName: '$searchtableName' ,Fields : '$sendFields' })
wiredContacts(result) 
{
   
    if(result.data!=undefined) 
    {
       
      
        this.wiredAccountList = result;
        console.log('columns');
        
        refreshApex(this.wiredAccountList);
        this.columns=[];
        this.listSelected=[];
        this.sendFields='';
        this.columns=column;
        column=[]
        this.data=result.data; 
       console.log(result.data);
      
        
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