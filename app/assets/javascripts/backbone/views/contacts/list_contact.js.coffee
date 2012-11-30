class Quota.Views.ListContact extends Backbone.View

	template: HandlebarsTemplates['contacts/list_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_remove": "destroy"
		"click .contact_link": "contactLinkClicked"
		# "blur .contact_method_val": "valChanged"
		# 		"blur .contact_method_name": "nameChanged"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@contact = options.contact
		@contact_types = options.contact_types
		@vent = options.vent
		@model.on('destroy', @remove, @)
		
	render: ->
		@contact_type = @getContactType()
		$(@el).html(@template({contact:@model.toJSON(), phones: @model.get("phones"), emails: @model.get("emails"), contact_type: @contact_type.toJSON() }))
		@
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		@vent.trigger('contacts:remove_contact', {model: @model})
		
	toggle: () ->
		$(@el).toggle()
		
	contactLinkClicked: ->
		@vent.trigger("contact_link:clicked", {view: @})
		
	getContactType: ->
		_.first(@contact_types.where({pub_key: @model.get("contact_type_key")}))