import { LightningElement,api,wire,track} from 'lwc';
import deletecontact from'@salesforce/apex/bookAccountData.delExposure';
import getContacts from'@salesforce/apex/bookAccountData.getExposureData';
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
    {label:'Book Name',fieldName:'Book__c'},
   {label:'Email',fieldName:'Email__c'},
   {type: 'action', typeAttributes: { rowActions: actions } } 
   
];
export default class ExposureData extends LightningElement {
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
       
         console.log(result.data);
          if(result.data!=undefined){
          
             this.samar=result.data;
           
            this.recordsize=result.data.length;
        console.log('size='+this.recordsize);
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
          console.log('a='+a);
        var allcontacts=[];
        var count=0;
        if(this.recordsize>=10){
            var b=a+parseInt(this.recordamount);
            }else{
               var b=this.recordsize; 
            }
        console.log('b'+b);
       console.log('samar');
       console.log(this.samar);
      
           for(var i=a;i<b;i++)
           {
            count++;
          
              allcontacts.push(this.samar[i]);
            
           }
           console.log(allcontacts);
       
           this.data=allcontacts;
          
        }
}