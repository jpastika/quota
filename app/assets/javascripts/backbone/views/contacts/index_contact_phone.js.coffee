class Quota.Views.IndexContactPhone extends Backbone.View

	template: HandlebarsTemplates['contacts/index_contact_phone'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_method_remove": "destroy"
		"blur input": "saveModel"
		"click .icon-remove": "destroy"
		
		# "click .contact_method_show_holder": "toggleEdit"
		
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
		$(@el).html(@template({contact_phone:@model.toJSON(), index:@index}))
		if @hideRemove
			@$('.contact_method_remove').css('visibility', 'hidden')
		
		@contact_method_show = @$('.contact_method_show')
		@contact_method_edit = @$('.contact_method_edit')

		@contact_method_show_name = @$('.contact_method_show_holder .contact_method_name')
		@contact_method_show_val = @$('.contact_method_show_holder .contact_method_val')
		@contact_method_name = @$('.contact_method_name')
		@contact_method_val = @$('.contact_method_val')
		@input_contact_method_name = @$('.contact_method_name input')
		@input_contact_method_val = @$('.contact_method_val input')
		
		@ok = @$('.icon-ok')
		@remove = @$('.icon-remove')
		@spinner = @$('.icon-spinner')
		
		@$('input, textarea').placeholder()
		
		
		
		
		# @$el.find('input').autoGrowInput()
		# 
		@
	
	decorateShow: ->

	setHolders: ->	
		@contact_method_show_name.html(@model.get("name"))
		@contact_method_show_val.html(@model.get("val"))
	
		
	# save: ->
	# 		self = @
	# 		@model.set("contact_key", @contact.get("pub_key"), {silent: true})
	# 		modelid = @model.id
	# 		if @input_contact_method_name.val() == ''
	# 			@model.set("name", "Phone", {silent: true})
	# 			
	# 		if @model.isValid(true) && @contact.isValid(true)
	# 			if @model.get("pub_key")
	# 				@model.url = 'phones/'+@model.get("pub_key")
	# 			else
	# 				@model.url = 'phones/'
	# 				
	# 			@model.save(
	# 				{
	# 					name: @model.get("name")
	# 					val: @model.get("val")
	# 				},
	# 				{
	# 					error: @handleError
	# 					success: (model) -> 
	# 						self.model.url = 'phones/'+model.get("pub_key")
	# 						self.hideRemove = false
	# 						self.model.trigger('change')
	# 						self.vent.trigger("contact_phones:check_empty")
	# 					silent: true
	# 				}
	# 			)
	
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
		@vent.trigger('contact_phones:remove_contact_phone', {model: @model})

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
				val: @input_contact_method_val.val()
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
					self.vent.trigger("contact_phone:updated", self.model)
			}
		)