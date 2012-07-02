window.Quota =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: ->
		window.Documents = new Quota.Routers.Documents()
		window.Contacts = new Quota.Routers.Contacts()
		Backbone.history.start(pushState: true)

$(document).ready ->
	Quota.init()
