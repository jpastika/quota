class Quota.Views.EditableContactPhone extends Backbone.View

	template: HandlebarsTemplates['contacts/editable_contact_phone'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_method_remove": "destroy"
		"blur .contact_method_val": "valChanged"
		"blur .contact_method_name": "nameChanged"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		Backbone.Validation.bind(
			@
			valid: (view, attr) ->
				self.clearError(attr)
			invalid: (view, attr, error) ->
				self.clearError(attr)
				self.handleError(attr, error)
		)
		@contact = options.contact
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.set("contact_key", @contact.get("pub_key"), {silent: true})
		@model.on('change', @render, @)
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({contact_phone:@model.toJSON()}))
		if @hideRemove
			@$('.contact_method_remove').hide()
		
		@contact_method_name = @$('.contact_method_name');
		@contact_method_val = @$('.contact_method_val');
		@input_contact_method_name = @$('.contact_method_name input');
		@input_contact_method_val = @$('.contact_method_val input');
		@
		
	save: ->
		self = @
		@model.set("contact_key", @contact.get("pub_key"), {silent: true})
		modelid = @model.id
		if @input_contact_method_name.val() == ''
			@model.set("name", "Phone", {silent: true})
			
		if @model.isValid(true) && @contact.isValid(true)
			if @model.get("pub_key")
				@model.url = 'phones/'+@model.get("pub_key")
			else
				@model.url = 'phones/'
				
			@model.save(
				{
					name: @model.get("name")
					val: @model.get("val")
				},
				{
					error: @handleError
					success: (model) -> 
						self.model.url = 'phones/'+model.get("pub_key")
						self.hideRemove = false
						self.model.trigger('change')
						self.vent.trigger("contact_phones:check_empty")
					silent: true
				}
			)

	handleSaveErrors: (model, response) ->
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for atttribute, messages of errors
				self.handleError(attribute, message)

	handleError: (attribute, message) ->
		@$el.find(".control-group.#{attribute}").addClass('error').last('.controls').append("<span class=\"help-inline\">#{message}</span>")

	clearError: (attribute) ->
		@$el.find(".control-group.#{attribute}").removeClass('error').find('.help-inline').remove()
		
	valChanged: ->
		@model.set("val", @input_contact_method_val.val(), {silent: true})
		@save()
	
	nameChanged: ->
		@model.set("name", @input_contact_method_name.val(), {silent: true})
		if @model.id
			@save()
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	toggle: () ->
		$(@el).toggle()
		
	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.contact_method_remove').hide()
		
	showRemove: () ->
		@hideRemove = false
		$(@el).find('.contact_method_remove').show()