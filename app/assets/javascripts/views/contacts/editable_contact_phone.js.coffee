class Quota.Views.EditableContactPhone extends Backbone.View

	template: HandlebarsTemplates['contacts/editable_contact_phone'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_method_val": "valClicked"
		"click .contact_method_name": "nameClicked"
		"click .contact_method_remove": "destroy"
		"blur .contact_method_val": "valChanged"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.on('change', @render, @)
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({contact_phone:@model.toJSON()}))
		if @hideRemove
			@$('.contact_method_remove').hide()
		
		@contact_method_name = @$('.contact_method_name');
		@contact_method_val = @$('.contact_method_val');
		@input_contact_method_va = @$('.contact_method_name input');
		@input_contact_method_val = @$('.contact_method_val input');
		@
		
	valClicked: (evt) ->
		console.log $(evt.target).val()
		
	valChanged: ->
		@model.set("val", @input_contact_name.val(), {silent: true})
		@save()
		
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