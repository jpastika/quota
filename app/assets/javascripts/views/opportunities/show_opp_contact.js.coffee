class Quota.Views.ShowOpportunityContact extends Backbone.View

	template: HandlebarsTemplates['opportunities/show_opp_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_remove": "destroy"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@contact = options.contact
		@company = if options.company then options.company else null
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.on('destroy', @remove, @)
		
	render: ->
		if @company
			comp = @company.toJSON()
		else
			comp = null
		$(@el).html(@template({opportunity_contact:@model.toJSON(), opportunity_contact_company: comp}))
		if @hideRemove
			@$('.contact_remove').css('visibility', 'hidden')
		@
		
	destroy: (evt) ->
		$(@el).toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.contact_remove').css('visibility', 'hidden')
		
	showRemove: () ->
		@hideRemove = false
		$(@el).find('.contact_remove').css('visibility', '')