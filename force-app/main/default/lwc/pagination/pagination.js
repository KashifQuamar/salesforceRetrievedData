import { LightningElement,api,track,wire} from 'lwc';
 import deletecontact from'@salesforce/apex/paginationClass.delrec';
import getContacts from'@salesforce/apex/paginationClass.getrecords';
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
export default class Pagination extends LightningElement {
    @api search;
    @track columns = columns;
    @track data = [];
    samar=[];
   currentpage=1;
   recordsize;
   recordamount=10;
    @track wiredAccountList = [];
  
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
           
             this.data=searchresult;
        }
        else{
           
           this.showdata();
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
  
  this.showdata();

}
 
    @wire(getContacts) 
            relatedrec(result){
          this.wiredAccountList = result;
       
         
          if(result.data!=undefined){
          
             this.samar=result.data;
           
            this.recordsize=result.data.length;
        
            this.showdata();
           
        }
       

      
        }
        handleOnNext(){
           
         if(this.currentpage<this.recordsize)
         {
            this.currentpage = this.currentpage + 1;
            this.showdata();
         }
         
        }


        handleOnPrev(){
            if(this.currentpage>1)
            {
               this.currentpage = this.currentpage -1;
               this.showdata();
            }
        }
        showdata(){
       
            var a=(this.currentpage-1)*parseInt(this.recordamount);
          
        var allcontacts=[];
        var count=0;
        var b=a+parseInt(this.recordamount);
       
      
           for(var i=a;i<b;i++)
           {
            count++;
          
              allcontacts.push(this.samar[i]);
            
           }
       
           this.data=allcontacts;
          
        }
    }