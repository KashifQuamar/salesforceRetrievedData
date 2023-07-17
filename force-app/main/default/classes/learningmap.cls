public class learningmap {
    public  void fun(){
        Map<Integer,String> map1=new Map<Integer,String>();
        map1.put(1,'kashif');
        map1.put(2,'kashif1');
        map1.put(3,'kashif2');
        
        System.debug('map1=>'+map1);
        map1.remove(2);
         System.debug(map1);
       Map<Integer,String> map2=new Map<Integer,String>();
        map2.put(1,'samar');
        map2.put(2,'samar2');
        System.debug(map2);
        map1.putAll(map2);
        System.debug(map1);
       list<Account> acc=[select id,name from account limit 2 ];
        Map<ID,Account> map3= new Map<ID,Account>(acc);
        System.debug(map3);
        list<string> str1= new list<string>();
        str1=map2.values();
        System.debug(str1);
        
    }
}