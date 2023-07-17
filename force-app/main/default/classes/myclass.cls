public class myclass {
    public void listmethod(){
        list<String> str=new list<String>();
         list<String> str2=new list<String>();
        list<String> str3=new list<String>();
        list<Integer> i=new list<Integer>();
        set<String> strset=new set<string>();
        
        
        Boolean b;
        //
        i.add(1);
         i.add(10);
        i.add(2);
        i.add(100);
        i.sort();
        System.debug(i);
// add,add(index,value),contains,clear,equals,addAll(list),addAll(set)        
        
        str.add('kashif1');
         str.add('1');
         str.add('10');
         str.add('2');
         str.add('3');
        str.add('kashif2');
        str.add('kashif3');
        str.add('kashif4');
        str.add('kashif5');
        str.add(2,'samar');
        str.add('quamar');
        str2.add('awesome');
        str2.addAll(str);
        
        
        strset.add('India');
        strset.add('china');
        str2.addAll(strset);
        str3.add('Aman');
        
        b=str2.contains('india');
        System.debug(b);
         System.debug('kashif is awwsome3='+str3);
        str3=str2.clone();
        
        System.debug('kashif is awwsome'+str);
          System.debug('kashif is awwsome'+str[2]);
          System.debug('kashif is awwsome'+str[3]);
        System.debug('kashif is awwsome2='+str2);
        System.debug('kashif is awwsome3='+str3);
        
        // Another type of method
        System.debug('this is another type');
        
        // get method
        System.debug('value='+str2.get(2));
        //sObject type
        sObject sobj=[select id,name from account limit 1];
        System.debug(sobj);
        // index of
        System.debug('value='+str2.indexof('India'));
        //sort
        str2.sort();
        System.debug('kashif is awwsome2='+str2);
        
        
        
        
        //
    }
}