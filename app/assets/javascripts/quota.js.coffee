window.Quota =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: ->
		window.Documents = new Quota.Routers.Documents()
		window.Contacts = new Quota.Routers.Contacts()
		window.vent = _.extend({}, Backbone.Events)
		Backbone.history.start(pushState: true)

$(document).ready ->
	Quota.init()
