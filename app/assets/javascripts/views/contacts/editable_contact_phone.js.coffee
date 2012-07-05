class Quota.Views.EditableContactPhone extends Backbone.View

	template: HandlebarsTemplates['contacts/editable_contact_phone'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_method_val": "valClicked"
		"click .contact_method_name": "nameClicked"
		"click .contact_method_remove": "destroy"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@model.on('change', @render, @)
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({contact_phone:@model.toJSON()}))
		@
		
	valClicked: (evt) ->
		console.log $(evt.target).val()
		
	nameClicked: (evt) ->
		console.log $(evt.target).val()
		
	destroy: (evt) ->
		@toggle()
		@model.trigger('removing', {view: @})
		@model.clear()
		
	toggle: () ->
		$(@el).toggle()
		
	hideRemove: () ->
		$(@el).find('.contact_method_remove').hide();
		
	showRemove: () ->
		$(@el).find('.contact_method_remove').show();