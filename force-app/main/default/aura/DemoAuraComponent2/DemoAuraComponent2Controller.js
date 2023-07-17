({
	doinit : function(component, event, helper) {
        component.set("v.Var1","this is the value from controller")
        var data={
            'name':'ankara',
            'email':'ankara@gmail.com',
            'Address':'Purnea Bihar'
            
        }
       component.set("v.jsObject",data) 
       component.set("v.WrapperClassUserData",
                     {
                         'mystring1':'this is string1',
                         'myInteger': 2000
                     }
       
       )
       
	},
      domessageone : function(component, event, helper) {
        
        component.set("v.message1","this is message from handler")
    },
    handleClick1 : function(component, event, helper) {
        var mes1=component.get("v.message1")
        var str1='this is message 1'
        var str2='this is changed message'
        if(mes1==str1)
        {
       
        component.set("v.message1",str2)
        }else{
          
           component.set("v.message1",str1)  
        }
        
    },
    handleClick2 : function(component, event, helper) {
        
        component.set("v.message2","this is message 2")
    }
  
})