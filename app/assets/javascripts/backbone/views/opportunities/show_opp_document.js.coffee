class Quota.Views.ShowOpportunityDocument extends Backbone.View

	template: HandlebarsTemplates['opportunities/show_opp_document'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-remove": "destroy"
	
	initialize: (options)->
			self = @
			_.bindAll(@)
			@vent = options.vent
			@hideRemove = if options.hideRemove then options.hideRemove else false
			@model.on('destroy', @remove, @)

	render: ->
		$(@el).html(@template({document:@model.toJSON()}))
		if @hideRemove
			@$('.document_remove').css('visibility', 'hidden')
		@

	destroy: (evt) ->
		$(@el).toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		@vent.trigger('opportunity_documents:remove_document', {model: @model})
		

	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.document_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		$(@el).find('.document_remove').css('visibility', '')