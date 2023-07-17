({
	doinit : function(component, event, helper) {
        component.set("v.columns",[
            {label:"First Name", fieldName:"FirstName",type:"text"},
            {label:"Last Name", fieldName:"LastName",type:"text"},
            {label:"Email" ,fieldName:"Email",type:"text"}
        ]);
        var result=component.get("c.getContactData")
        result.setCallback(this,function(response)
        {
             var state=response.getState();  
            if(state === "SUCCESS")
            {
                component.set("v.conlist",response.getReturnValue());
            }
         });
        $A.enqueueAction(result);
        
		
	},
     onChange: function (component, event, helper) {
    	
         	console.log(component.find("distance").get("v.value"));
          var result=component.get("c.getSearchedContact")
            result.setParams({
            conid:component.find("distance").get("v.value")
        });
         result.setCallback(this,function(response)
        {
            console.log(response);
             var state=response.getState(); 
              console.log(state);
            if(state === "SUCCESS")
            {
                component.set("v.contacts",response.getReturnValue());
            }
         });
        $A.enqueueAction(result);
    }
  
})