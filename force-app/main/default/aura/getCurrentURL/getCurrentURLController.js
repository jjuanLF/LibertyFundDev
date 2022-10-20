({
	// When a flow executes this component, it calls the invoke method
	invoke : function(component, event, helper) {
		component.set("v.url", window.location.href);
	}
})