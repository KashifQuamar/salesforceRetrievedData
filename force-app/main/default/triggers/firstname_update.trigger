trigger firstname_update on Lead (before insert) {
Map<String, String> maping = new Map<String, String>();
maping.put('Doctor','Dr');
maping.put('Engineer','Er');
maping.put('Lawyer','Lr');
maping.put('Others','');
 for(lead a : Trigger.new) {
     a.FirstName=Maping.get(a.Occupation__c)+'.'+' '+a.FirstName;
      
      
    }   

}