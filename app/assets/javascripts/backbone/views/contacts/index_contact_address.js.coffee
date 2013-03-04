class Quota.Views.IndexContactAddress extends Backbone.View

	template: HandlebarsTemplates['contacts/index_contact_address'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_method_remove": "destroy"
		"blur input": "saveModel"
		"click .icon-remove": "destroy"
		
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
		@model.on('destroy', @remove, @)
		
		@vent.on('contact:edit', @handleEdit, @)
		@vent.on('contact:done', @handleDone, @)
		
	render: ->
		$(@el).html(@template({contact_address:@model.toJSON(), index:@index}))
		if @hideRemove
			@$('.contact_method_remove').css('visibility', 'hidden')
			
		@contact_method_show = @$('.contact_method_show')
		@contact_method_edit = @$('.contact_method_edit')
		
		@contact_method_name = @$('.contact_method_name')
		@contact_method_street1 = @$('.contact_method_street1')
		@contact_method_street2 = @$('.contact_method_street2')
		@contact_method_city = @$('.contact_method_city')
		@contact_method_state = @$('.contact_method_state')
		@contact_method_zip = @$('.contact_method_zip')
		@contact_method_country = @$('.contact_method_country')
		
		@contact_method_show_name = @$('.contact_method_show_holder .contact_method_name')
		@contact_method_show_street1 = @$('.contact_method_show_holder .contact_method_show_street1')
		@contact_method_show_street2 = @$('.contact_method_show_holder .contact_method_show_street2')
		@contact_method_show_city = @$('.contact_method_show_holder .contact_method_show_city')
		@contact_method_show_state = @$('.contact_method_show_holder .contact_method_show_state')
		@contact_method_show_zip = @$('.contact_method_show_holder .contact_method_show_zip')
		@contact_method_show_country = @$('.contact_method_show_holder .contact_method_show_country')
		
		@input_contact_method_name = @$('.contact_method_name input')
		@input_contact_method_street1 = @$('.contact_method_street1')
		@input_contact_method_street2 = @$('.contact_method_street2')
		@input_contact_method_city = @$('.contact_method_city')
		@input_contact_method_state = @$('.contact_method_state')
		@input_contact_method_zip = @$('.contact_method_zip')
		@input_contact_method_country = @$('.contact_method_country')
		@input_contact_method_pub_key = @$('.contact_method_pub_key')
		
		@ok = @$('.icon-ok')
		@remove = @$('.icon-remove')
		@spinner = @$('.icon-spinner')
		
		@$('input, textarea').placeholder()
		
		
		
		# @$el.find('input').autoGrowInput()
		@
	
	decorateShow: ->

	setHolders: ->	
		@contact_method_show_name.html(@model.get("name"))
		@contact_method_show_street1.html(@model.get("street1"))
		@contact_method_show_street2.html(@model.get("street2"))
		@contact_method_show_city.html(@model.get("city"))
		@contact_method_show_state.html(@model.get("state"))
		@contact_method_show_zip.html(@model.get("zip"))
		@contact_method_show_country.html(@model.get("country"))


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
		$(@el).toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		@vent.trigger('contact_addresses:remove_contact_address', {model: @model})

	toggle: () ->
		$(@el).toggle()
		
	handleEdit: ->
		@contact_method_show.hide()
		@contact_method_edit.show()
		
	handleDone: ->
		@contact_method_edit.hide()
		@contact_method_show.show()
		
	toggleEdit: ->
		@contact_method_show.hide()
		@contact_method_edit.show()

	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.contact_method_remove').css('visibility', 'hidden')
		
	showRemove: () ->
		@hideRemove = false
		$(@el).find('.contact_method_remove').css('visibility', '')
		
	showSpinner: ->
		@spinner.show()

	hideSpinner: ->
		@spinner.hide()

	saveModel: ->
		self = @
		@showSpinner()
		@model.save(
			{
				name: @input_contact_method_name.val()
				street1: @input_contact_method_street1.val()
				street2: @input_contact_method_street2.val()
				city: @input_contact_method_city.val()
				state: @input_contact_method_state.val()
				zip: @input_contact_method_zip.val()
				country: @input_contact_method_country.val()
			},
			{
				error: ->
					self.hideSpinner()
					# console.log "save error"
				success: (model) -> 
					# self.vent.trigger('template_items:add_new_template_item_successful', {model: model})
					self.setHolders()
					self.decorateShow()
					self.hideSpinner()
					self.vent.trigger("contact_address:updated", self.model)
			}
		)