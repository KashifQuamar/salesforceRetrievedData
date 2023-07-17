public class contactWrapperList{

public list<contactWrapper> listcon{get;set;}


public contactWrapperList(){
    listcon= new list<contactWrapper>();
    
    try{
        list<contact> con_q=[select id,name,email from contact];
       for(contact cc:con_q){
             contactWrapper conw=new contactWrapper();
        conw.cont=cc;
       conw.isSelected=false;
         listcon.add(conw);
}
        System.debug(listcon);

    }
    catch(exception e)
    {
        System.debug('erroris ');
        System.debug(e);
        system.debug(e.getMessage());
        system.debug(e.getLineNumber());
    }
}


public class contactWrapper{
public contact cont{get;set;}
public boolean isSelected{get;set;}

public contactWrapper(){
this.cont=new contact();
this.isSelected=false;
}

}

}