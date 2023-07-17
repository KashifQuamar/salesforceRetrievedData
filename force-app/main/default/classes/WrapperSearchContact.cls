public class WrapperSearchContact {
    
    public list<wrapperClassContact> wrapconlist{get;set;}
    
    public WrapperSearchContact(){
        wrapconlist =new list<wrapperClassContact>();
        
         try{
        list<contact> con_q=[select id,name,email from contact];
       for(contact cc:con_q){
            wrapperClassContact conw=new wrapperClassContact();
        conw.allContact=cc;
       conw.usermail=UserInfo.getUserEmail();
         wrapconlist.add(conw);
         }
        System.debug(wrapconlist);

    }
    catch(exception e)
    {
        System.debug('erroris ');
        System.debug(e);
        system.debug(e.getMessage());
        system.debug(e.getLineNumber());
    }
        
        
    }
    
 public class wrapperClassContact{
        public contact allContact{get;set;}
        public string usermail{get;set;}
            
            
            public wrapperClassContact(){
                this.allContact=new Contact();
                this.usermail='';
            }
    }
    

}