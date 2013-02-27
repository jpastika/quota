class Quota.Views.ListContact extends Backbone.View

	template: HandlebarsTemplates['contacts/list_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-remove": "destroy"
		"click .contact_name": "contactClicked"
		# "blur .contact_method_val": "valChanged"
		# 		"blur .contact_method_name": "nameChanged"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@contact = options.contact
		# @contact_types = options.contact_types
		@vent = options.vent
		@model.on('destroy', @remove, @)
		@model.on('change', @render, @)
		
	render: ->
		# @contact_type = @getContactType()
		$(@el).html(@template({contact:@model.toJSON(), phones: @model.get("phones"), emails: @model.get("emails")}))
		@
		
	destroy: (evt) ->
		# @toggle()
		# 		# @model.trigger('removing', {view: @})
		# 		@model.remove()
		# 		@vent.trigger('contacts:remove_contact', {model: @model})
		
	toggle: () ->
		$(@el).toggle()
		
	contactLinkClicked: ->
		@vent.trigger("contact_link:clicked", {view: @})
	
	contactClicked: ->
		@vent.trigger("contact:clicked", {model: @model, view: @})
		
	highlight: ->
		$(@el).addClass('row_selected')
	
	unhighlight: ->
		$(@el).removeClass('row_selected')
		
	getContactType: ->
		_.first(@contact_types.where({pub_key: @model.get("contact_type_key")}))