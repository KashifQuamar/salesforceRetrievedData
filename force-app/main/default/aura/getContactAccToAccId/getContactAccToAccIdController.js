({
	myAction : function(component, event, helper) {
		component.set("v.columns",[
            {label:"First Name", fieldName:"FirstName",type:"text"},
            {label:"Last Name", fieldName:"LastName",type:"text"},
            {label:"Email" ,fieldName:"Email",type:"text"}
        ]);
        var action=component.get("c.getContacts")
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this,function(data)
                           {
                               component.set("v.contacts", data.getReturnValue());
                           });
        $A.enqueueAction(action);
	}
})