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
		@vent = options.vent
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({contact:@model.toJSON()}))
		@
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	toggle: () ->
		$(@el).toggle()
		
	contactLinkClicked: ->
		@vent.trigger("contact_link:clicked", {view: @})