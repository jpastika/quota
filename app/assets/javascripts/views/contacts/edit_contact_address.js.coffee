class Quota.Views.EditContactAddress extends Backbone.View

	template: HandlebarsTemplates['contacts/edit_contact_address'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_method_remove": "destroy"
		"blur .contact_method_address": "valChanged"
		"blur .contact_method_name": "nameChanged"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		# 		Backbone.Validation.bind(
		# 			@
		# 			valid: (view, attr) ->
		# 				self.clearError(attr)
		# 			invalid: (view, attr, error) ->
		# 				self.clearError(attr)
		# 				self.handleError(attr, error)
		# 		)
		@contact = options.contact
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.set("contact_key", @contact.get("pub_key"), {silent: true})
		@model.on('change', @render, @)
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({contact_address:@model.toJSON()}))
		if @hideRemove
			@$('.contact_method_remove').hide()
		
		@contact_method_name = @$('.contact_method_name');
		@contact_method_val = @$('.contact_method_val');
		@input_contact_method_name = @$('.contact_method_name input');
		@input_contact_method_street1 = @$('.contact_method_address input[name="contact_address[street1]"]');
		@input_contact_method_city = @$('.contact_method_address input[name="contact_address[city]"]');
		@input_contact_method_state = @$('.contact_method_address input[name="contact_address[state]"]');
		@input_contact_method_zip = @$('.contact_method_address input[name="contact_address[zip]"]');
		@input_contact_method_country = @$('.contact_method_address input[name="contact_address[country]"]');
		
		@$el.find('input').autoGrowInput()
		@
		
	save: ->
		self = @
		@model.set("contact_key", @contact.get("pub_key"), {silent: true})
		modelid = @model.id
		if @input_contact_method_name.val() == ''
			@model.set("name", "Address", {silent: true})
			
		# if @model.isValid(true) && @contact.isValid(true)
		if @model.get("pub_key")
			@model.url = 'addresses/'+@model.get("pub_key")
		else
			@model.url = 'addresses/'
			
		@model.save(
			{
				name: @model.get("name")
				val: @model.get("val")
			},
			{
				error: @handleError
				success: (model) -> 
					self.model.url = 'addresses/'+model.get("pub_key")
					self.hideRemove = false
					self.showRemoveButton()
					self.input_contact_method_name.val(model.get("name"))
					# self.model.trigger('change')
					self.vent.trigger("contact_addresses:check_empty")
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
		@model.set("street1", @input_contact_method_street1.val(), {silent: true})
		@model.set("city", @input_contact_method_city.val(), {silent: true})
		@model.set("state", @input_contact_method_state.val(), {silent: true})
		@model.set("zip", @input_contact_method_zip.val(), {silent: true})
		@model.set("country", @input_contact_method_country.val(), {silent: true})
		@save()
	
	nameChanged: (evt)->
		@model.set("name", @input_contact_method_name.val(), {silent: true})
		if @model.id
			@save()
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	toggle: () ->
		$(@el).toggle()
		
	hideRemoveButton: () ->
		@hideRemove = true
		$(@el).find('.contact_method_remove').hide()
		
	showRemoveButton: () ->
		@hideRemove = false
		$(@el).find('.contact_method_remove').show()