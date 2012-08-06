class Quota.Views.CompanyContactAdd extends Backbone.View

	template: HandlebarsTemplates['contacts/company_contact_add'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .btn": "addContact"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		$(@el).html(@template({contact:@model.toJSON()}))
		@
		
	addContact: ->
		@vent.trigger("company_contacts:add_contact", {contact:@model, view: @})
		
	save: ->
		# self = @
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
		# 
		# 	handleSaveErrors: (model, response) ->
		# 		if response.status == 422
		# 			errors = $.parseJSON(response.responseText).errors
		# 			for atttribute, messages of errors
		# 				self.handleError(attribute, message)
		# 
		# 	handleError: (attribute, message) ->
		# 		@$el.find(".control-group.#{attribute}").addClass('error').last('.controls').append("<span class=\"help-inline\">#{message}</span>")
		# 
		# 	clearError: (attribute) ->
		# 		@$el.find(".control-group.#{attribute}").removeClass('error').find('.help-inline').remove()