({
	doinit : function(component, event, helper) {
        $A.createComponent(
            "lightning:button",{
                "aura:id" :"findableAuraId",
                "label" : "Click Me",
                "onclick" : component.getReference("c.handleclick")
            },
                function(newButton,status,errorMessage)
                {
                if(status==="SUCCESS")
                {
                   var body=component.get("v.body");
                   body.push(newButton);
                    component.set("v.body",body);
                }
                else if(status==="INCOMPLETE")
                {
                    console.log("No response from server or client is offline");
                    console.log("Error Message=> "+errorMessage )
                }
            }
        );
	},
    handleclick: function(component,event,helper)
    {
        component.set("v.message","Button Clicked");
    }
})