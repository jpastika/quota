window.Quota =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: ->
		enablePushState = true  
		pushState = !!(enablePushState and window.history and window.history.pushState)
		window.Documents = new Quota.Routers.Documents()
		window.Contacts = new Quota.Routers.Contacts()
		window.vent = _.extend({}, Backbone.Events)
		Backbone.history.start({ pushState: pushState })
		
$(document).ready ->
	Quota.init()