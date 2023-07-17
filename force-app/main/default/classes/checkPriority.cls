public class checkPriority {
 public static string getPriority(string priority)
 {
     if(string.isBlank(priority) || priority.length()>2)
     {
         return null;
     }
     string setPriority;
     if(priority=='CA')
     {
        setPriority='HIGH';
     }
     else{
          setPriority='NORMAL';
     }
     return setPriority;
 }
}