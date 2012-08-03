class Quota.Views.ShowOpportunityContact extends Backbone.View

	template: HandlebarsTemplates['opportunities/show_opp_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_remove": "destroy"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@contact = options.contact
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({contact:@model.toJSON()}))
		if @hideRemove
			@$('.contact_remove').css('visibility', 'hidden')
		@
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.contact_method_remove').css('visibility', 'hidden')
		
	showRemove: () ->
		@hideRemove = false
		$(@el).find('.contact_method_remove').css('visibility', '')