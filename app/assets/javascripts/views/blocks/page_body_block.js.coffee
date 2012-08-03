class Quota.Views.PageBodyBlock extends Backbone.View

	tagName: 'div'
	className: 'main_body'
	
	events:
		"click": "pageBodyClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		$(@el).html(@template())
		@
		
	pageBodyClicked: ->
		console.log "Page Body Clicked"
