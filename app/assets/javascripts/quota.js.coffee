window.Quota =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: ->
		window.aaa = new Quota.Routers.Quotes()
		Backbone.history.start(pushState: true)

$(document).ready ->
	Quota.init()
