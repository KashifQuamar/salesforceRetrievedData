public class bookAccountData{
@AuraEnabled(cacheable=true)
public static list<book__c> getBookData(){
list<Book__c> booklist=[select id,Name,Email__c from book__c];
return booklist;
}
@AuraEnabled(cacheable=true)
public static list<guide__c> getGuideData(){
list<guide__c> booklist=[select id,Name,Email__c,Company_Name__c from guide__c];
return booklist;
}
@AuraEnabled(cacheable=true)
public static list<chance__c> getChanceData(){
list<chance__c> booklist=[select id,Name,Email__c,Book_Name__r.name from chance__c];
return booklist;
}
@AuraEnabled(cacheable=true)
public static list<exposure__c> getExposureData(){
list<exposure__c> booklist=[select id,Name,Email__c,Book__r.name from exposure__c];
return booklist;
}
@AuraEnabled(cacheable=true)
public static list<agreement__c> getAgreementData(){
list<agreement__c> booklist=[select id,Name,Email__c,Book__r.name from agreement__c];
return booklist;
}
@AuraEnabled
public static void delrec(string c){
system.debug(c);
book__c cc=new book__c();
cc.id=c;
delete cc;
}
@AuraEnabled
public static void delguide(string c){
system.debug(c);
guide__c cc=new guide__c();
cc.id=c;
delete cc;
}
@AuraEnabled
public static void delchance(string c){
system.debug(c);
chance__c cc=new chance__c();
cc.id=c;
delete cc;
}
@AuraEnabled
public static void delExposure(string c){
system.debug(c);
exposure__c cc=new exposure__c();
cc.id=c;
delete cc;
}
@AuraEnabled
public static void delAgreement(string c){
system.debug(c);
agreement__c cc=new agreement__c();
cc.id=c;
delete cc;
}
}