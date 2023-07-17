public class customDetailsOfObjects {
 @AuraEnabled(cacheable=true)
public static void getdata(String objectApiName,String Fields)
{
    String obj='from '+objectApiName;
    String query='select'+Fields+obj;
    System.debug(query);
}
}