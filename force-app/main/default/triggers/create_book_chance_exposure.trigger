trigger create_book_chance_exposure on Guide__c (after insert) {
list<book__c> booklist=new list<book__c>();
list<Chance__c> chancelist=new list<Chance__c>();
list<exposure__c> exposurelist=new list<exposure__c>();

for(Guide__c g:trigger.new)
{
if(g.Lead_Status__c=='Closed-Converted')
{
  book__c bok= new book__c();
  bok.name=g.Company_Name__c;
  bok.email__c=g.email__C;
  bok.website__c=g.website__c;
  
  insert bok;
  system.debug(bok.id);
  chance__c chan=new chance__c();
  chan.name=g.name+'-'+g.Company_Name__c;
  chan.Book_Name__c=bok.id;
  chan.email__c=g.email__c;
  chan.All_Products_selected__c=g.Product_Name_and_Quantity__c; 
 
 system.debug(chan);
  insert chan;
  exposure__c expo=new exposure__c();
  expo.name=g.name;
  expo.Book__c=bok.id;
  expo.email__c=g.email__c;
  expo.mobile__c=g.Phone__c;
  
  insert expo;
  system.debug(expo);

}
}




}