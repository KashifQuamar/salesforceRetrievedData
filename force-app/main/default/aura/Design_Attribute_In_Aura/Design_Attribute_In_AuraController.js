({
	doinit : function(component, event, helper) {
		 var result=component.get("c.getObjectNames")
        result.setCallback(this,function(response)
        {
             var state=response.getState();  
            if(state === "SUCCESS")
            {
                component.set("v.objlist",response.getReturnValue());
            }
         });
        $A.enqueueAction(result);
	},
    onChange: function (component, event, helper) {
    	
         	console.log(component.find("distance").get("v.value"));
          var result=component.get("c.getFieldName")
            result.setParams({
            objectName:component.find("distance").get("v.value")
        });
         result.setCallback(this,function(response)
        {
            console.log(response);
             var state=response.getState(); 
              console.log(state);
            if(state === "SUCCESS")
            {
                 console.log(response.getReturnValue());
                console.log('returned values');
                // console.log(response.getReturnValue().values());
                var result=response.getReturnValue();
                
                 var keys=Object.keys(result);
                var values=Object.values(result);
                console.log(keys);
                console.log(values);
                 var plValues = [];
                for (var i = 0; i < keys.length; i++) {
                    plValues.push({
                        label: values[i],
                        value: keys[i]
                    });
                }
                component.set("v.picklistValues",plValues);
            }
         });
        $A.enqueueAction(result);
    },
    searchData:function (component, event, helper) {
         var selectedValues = component.get("v.selectedValues");
         console.log('Selectd Genre-' + selectedValues);
         console.log(typeof(selectedValues));
        console.log(component.find("distance").get("v.value"));
        
        
        var objectName=component.find("distance").get("v.value")
        var result=component.get("c.getFieldsData")
            result.setParams({
                objectApiName:objectName,
                Fields:selectedValues
               
        });
          result.setCallback(this,function(response)
        {
            console.log('this is setCallBack function');
            console.log(response);
             var state=response.getState(); 
              console.log(state);
            if(state === "SUCCESS")
            {
                 console.log(response.getReturnValue());
                console.log('returned values');
            }
        });
        $A.enqueueAction(result);
         console.log(result);
    }
})