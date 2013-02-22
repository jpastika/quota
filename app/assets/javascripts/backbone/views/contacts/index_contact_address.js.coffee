class Quota.Views.IndexContactAddress extends Backbone.View

	template: HandlebarsTemplates['contacts/index_contact_address'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_method_remove": "destroy"
		"click .contact_method_show_holder": "toggleEdit"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		# Backbone.Validation.bind(
		# 			@
		# 			valid: (view, attr) ->
		# 				self.clearError(attr)
		# 			invalid: (view, attr, error) ->
		# 				self.clearError(attr)
		# 				self.handleError(attr, error)
		# 		)
		@contact = options.contact
		@index = options.index
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.set("contact_key", @contact.get("pub_key"), {silent: true})
		@model.on('change', @render, @)
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({contact_address:@model.toJSON(), index:@index}))
		if @hideRemove
			@$('.contact_method_remove').css('visibility', 'hidden')
			
		@contact_method_show = @$('.contact_method_show')
		@contact_method_edit = @$('.contact_method_edit')
		
		@contact_method_name = @$('.contact_method_name')
		@contact_method_street1 = @$('.contact_method_street1')
		@contact_method_city = @$('.contact_method_city')
		@contact_method_state = @$('.contact_method_state')
		@contact_method_zip = @$('.contact_method_zip')
		@contact_method_country = @$('.contact_method_country')
		@input_contact_method_name = @$('.contact_method_name input')
		@input_contact_method_street1 = @$('.contact_method_street1')
		@input_contact_method_city = @$('.contact_method_city')
		@input_contact_method_state = @$('.contact_method_state')
		@input_contact_method_zip = @$('.contact_method_zip')
		@input_contact_method_country = @$('.contact_method_country')
		
		# @$el.find('input').autoGrowInput()
		@
		
	save: ->
		

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
		if @shouldSave()
			@model.set("val", @input_contact_method_val.val(), {silent: true})
			@save()
			
	shouldSave: ->
		if @input_contact_method_val.val() != '' or !@model.isNew()
			return true
		else
			return false
	
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
		
	toggleEdit: ->
		@contact_method_show.hide()
		@contact_method_edit.show()

	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.contact_method_remove').css('visibility', 'hidden')
		
	showRemove: () ->
		@hideRemove = false
		$(@el).find('.contact_method_remove').css('visibility', '')