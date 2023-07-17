public class calculating_opportunity_based_on_email{
 public static void get_email_and_accid(map<id,list<string>> newmap){
 System.debug('this is apex class newmap'+newmap);
 list<string> email_string =new list<string>();
 list<account> acc_list =new list<account>();
 map<id,map<string,list<string>>> outermap= new  map<id,map<string,list<string>>>();
 system.debug('this is apex class'+newmap.values());
 list<opportunity> opp_list=new list<opportunity>();
 System.debug(newmap.values());
 list<string> newstring=new list<string>();
 for(list<string> ls:newmap.values()){
   newstring.addall(ls);
 }
 System.debug('this is email=> '+newstring);
 opp_list=[select id,email__c ,name,account.email__c from opportunity where accountid in:newmap.keyset() and email__c in:newstring];
 
 system.debug('this is query'+opp_list);
 if(opp_list.size()>0){
 for(opportunity opp:opp_list) 
 {
 email_string.add(opp.account.email__c);
 System.debug('this is parent'+opp.account.email__c);
 System.debug('this is child'+opp.email__c);
// if(opp.account.email__c==opp.email__c){
 System.debug('this is parent enter234567'+opp.account.email__c);

   if(outermap.containskey(opp.accountid))
   {
   map<string,list<string>> innermap2=outermap.get(opp.accountid);
   if(innermap2.containskey(opp.email__c))
   {
   list<string> naams=innermap2.get(opp.email__c);
   naams.add(opp.name);
   innermap2.put(opp.email__c,naams);
   outermap.put(opp.accountid,innermap2);
   }
   else{
   map<string,list<string>> innermap3=outermap.get(opp.accountid);
   innermap3.put(opp.email__c,new list<string>{opp.name});
   outermap.put(opp.accountid,innermap3);
   }
   }else{
    map<string,list<string>> innermap=new  map<string,list<string>>();
     innermap.put(opp.Email__c,new list<string>{opp.name});
     outermap.put(opp.accountid,innermap);
   }
 }
 }
 //}
 System.debug('this is outermap'+outermap);
 System.debug('this is outermap'+outermap.size());
 if(outermap.size()>0){
 for(id i:newmap.keyset())
 {
   System.debug('00000000000000000000000');
 if(outermap.containskey(i)){
 for(string s:newstring){
 System.debug('9999999999999999999==='+s);
 System.debug('111111111111111111111111111');
 if(outermap.size()>0){
 if(email_string.contains(s)){
 system.debug('this is last for loop');
 system.debug('this is last for loop'+s);
 account acc=new account();
 acc.id=i;
 acc.No_of_opportunity_by_email__c=outermap.get(i).get(s).size();
 acc_list.add(acc);
 }}
 }
 }
 else{
 system.debug('this is else part');
 account acc=new account();
 acc.id=i;
 acc.No_of_opportunity_by_email__c=0;
 acc_list.add(acc);
 }
 }
 }
 System.debug(acc_list);
 update acc_list;
 }
 }