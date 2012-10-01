class Quota.Views.IndexOpportunity extends Backbone.View

	template: HandlebarsTemplates['opportunities/index_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .opportunity_remove": "destroy"
		"click .opportunity_link": "opportunityLinkClicked"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@opportunity = options.opportunity
		@vent = options.vent
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({opportunity:@model.toJSON()}))
		@
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	toggle: () ->
		$(@el).toggle()
		
	opportunityLinkClicked: ->
		@vent.trigger("opportunity_link:clicked", {view: @})