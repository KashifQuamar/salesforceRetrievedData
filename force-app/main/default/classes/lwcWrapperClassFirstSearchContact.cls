public class lwcWrapperClassFirstSearchContact {
 
    
    @AuraEnabled(cacheable=true)
    public static list<wrapperClassContact> getAllData(){

       list<wrapperClassContact> wrapconlist=new list<wrapperClassContact>();
        
        list<contact> con_q=[select id,name,email from contact];
       for(contact cc:con_q){
            wrapperClassContact conw=new wrapperClassContact();
        conw.allContact=cc;
       conw.usermail=UserInfo.getUserEmail();
         wrapconlist.add(conw);
    }
         System.debug(wrapconlist);
    return wrapconlist;
        
        
    }
    
 public class wrapperClassContact{
      @AuraEnabled
        public contact allContact{get;set;}
        @AuraEnabled
        public string usermail{get;set;}
            
             
            public wrapperClassContact(){
                this.allContact=new Contact();
                this.usermail='';
            }
    }
    

}