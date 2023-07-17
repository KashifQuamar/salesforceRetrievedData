import { LightningElement,api,wire,track} from 'lwc';
import getContacts from'@salesforce/apex/lwcWrapperClassFirstSearchContact.getAllData';

export default class WrappperSearchINContact extends LightningElement {
    @track actions = [
        {label: 'View', name: 'view'},
        {label: 'Edit', name: 'edit'},
        {label: 'Delete', name: 'delete'}
    ];
    temp;
    dummydata=[]
    @track userIdWithContacts;
    @track error;
  
    handleOnClick(){
        var inp=this.template.querySelectorAll("lightning-input");
        inp.forEach(function(element){
            if(element.name=="search"){
                this.search=element.value;
                console.log('this is firstname');
                
                console.log(this.search);
            }
        },this);
        console.log('searching=>'+this.search);
      
       var  l=this.dummydata.length;
        var first=this.search.toUpperCase();
        console.log(first);
        console.log('first lenth==============>'+first.length);
        console.log('length='+l);
        console.log(this.dummydata[0].allContact);
       var searchresult=[];
       if(first.length>0){
        for(let i=0;i<l;i++)
        { 
            var q= this.dummydata[i].allContact.Name;
           var e=this.dummydata[i].allContact.Email;
          
          
            var second=q.toUpperCase();
          
            if(e!='' && e!=null && e!=undefined){
                // console.log(typeof(e));
                // console.log('e='+e);
                var f=e.toUpperCase();
             if(f.match(first))
            {
                searchresult.push(this.dummydata[i]);
            }
            else if(second.match(first))
        {
            searchresult.push(this.dummydata[i]);
            console.log('second=>'+second);
          
        }
           
        }
        else if(second.match(first))
        {
            searchresult.push(this.dummydata[i]);
            console.log('second=>'+second);
           
        }
        
        }
    }
        console.log('this is search');
        console.log(searchresult);
        console.log('search lenth='+searchresult.length);
        if(searchresult.length>0)
        {
           
             this.userIdWithContacts=searchresult;
        }
        else{
            this.userIdWithContacts=this.dummydata;
           
        }
       
        // this.relatedrec();

    }
    @wire(getContacts)
    wiredAccountsWithContacts({data, error }) {
        if (data) {
            this.userIdWithContacts = data;
          
            console.log('hihihihihihihihihihihihihih');
            console.log(data);
            // this.temp=data;
            this.dummydata=data;
            // console.log('temp');
            // console.log(temp);
            console.log('dummydata');
            console.log(this.dummydata[0].allContact);
            console.log(this.dummydata.length);
          
        } else if (error) {
            console.log(error);
            this.error = error;
        }
    }

}