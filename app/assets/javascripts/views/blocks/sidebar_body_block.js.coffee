class Quota.Views.SidebarBodyBlock extends Backbone.View

	tagName: 'div'
	className: 'sidebar_body'
	
	events:
		"click": "sidebarBodyClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		$(@el).html(@template())
		@
		
	sidebarBodyClicked: ->
