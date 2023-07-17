public with sharing class wrapperClass {

    

public  list<Account> acclist{get;set;}
public list<kashifanmol> wraplist{get;set;}


public PageReference delval() {

list<account> dellist=new list<account>();
for(kashifanmol ka:wraplist){
if(ka.isselected==true){
  dellist.add(ka.kashifacc);
}

}

if(!dellist.isEmpty()){
delete dellist;


}
      PageReference pageRef=ApexPages.currentPage();
      pageRef.setRedirect(true);
      return pageRef;
    }


public wrapperClass(){
acclist=[select id,name,annualrevenue from account limit 50];
wraplist= new list<kashifanmol>();
if(!acclist.isEmpty()){
for(Account acr:acclist)
{
 wraplist.add(new kashifanmol(acr,false));
}
}

}


public class kashifanmol{
public Account kashifacc{get;set;}
public Boolean isselected{get;set;}
public kashifanmol(Account a,boolean br){
kashifacc=a;
isselected=br;
}
}
}