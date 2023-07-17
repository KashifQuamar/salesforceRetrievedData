({
	doinit : function(component, event, helper) {
        var result=component.get("c.getAccountData")
        result.setCallback(this,function(response)
        {
             var state=response.getState();  
            if(state === "SUCCESS")
            {
                component.set("v.acclist",response.getReturnValue());
            }
         });
        $A.enqueueAction(result);
        
		
	},
     onChange: function (component, event, helper) {
    	
         	console.log(component.find("distance").get("v.value"));
    }
  
    
})