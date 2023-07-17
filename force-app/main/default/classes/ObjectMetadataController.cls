public class ObjectMetadataController {
@AuraEnabled(cacheable=true)
    public static List<String> getObjectNames() {
        List<String> objectNames = new List<String>();
        
        for (Schema.SObjectType objectType : Schema.getGlobalDescribe().values()) {
            objectNames.add(objectType.getDescribe().getName());
        }
        
        return objectNames;
    }
    @AuraEnabled(cacheable=true)
 public static map<string,string> getFieldName(String objectName)
 {
 system.debug(objectName);
 list<string> allFieldName =new list<string>();
 map<string,string> newmap=new map<string,string>();
 Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
Map <String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
for(Schema.SObjectField sfield : fieldMap.Values())
{
schema.describefieldresult dfield = sfield.getDescribe();
system.debug('@@@API Name : '  + dfield.getname());
system.debug('####Label Name : ' + dfield.getLabel ());
newmap.put(dfield.getname(), dfield.getLabel ());
allFieldName.add(dfield.getLabel ());
}
System.debug(allFieldName);
System.debug(newmap);
return newmap;
 }
    
    
    
  @AuraEnabled(cacheable=true)
    public static list<Sobject> getFieldsData(String objectApiName,String Fields)
{
    system.debug(objectApiName);
    system.debug(Fields);
    String obj=' from '+objectApiName;
    String query='select '+Fields+obj;
    System.debug(query);
    list<sobject> result=Database.query(query);
    
    return result;
}
    @AuraEnabled(cacheable=true)
    public static string getdata(String objectApiName)
    {
        system.debug(objectApiName);
        return 'hello world';
    }
}