class Quota.Views.EditContact extends Backbone.View

	template: HandlebarsTemplates['contacts/editable_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events: {
		"keydown .contact_company_name":	"company_name_changed"
		"blur .contact_name":	"contact_name_changed"
	}
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@contact_types = options.contact_types
		@_contactTypesView = null
		@model.on('change', @render, @)
		@vent.on('contact_type:clicked', @contact_type_clicked, @)
		
	render: ->
		$(@el).html(@template({contact:@model.toJSON()}))
		@input_contact_name = @$('.contact_name');
		@input_contact_title = @$('.contact_title');
		@input_contact_company_name = @$('.company_name');
		@input_contact_company_key = @$('.company_key');
		@input_contact_type_key = @$('.contact_type_key');
		@container_contact_types = @$('#contact_types');
		
		@_contactTypesView = new Quota.Views.ContactTypesToggles({model:@model, collection:@contact_types, contact: @model, vent: @vent})
		@container_contact_types.html(@_contactTypesView.render().el)
		@
		
	# reset_contact_types: ->
	# 		# @vent.trigger('contact_types:reset')
		
	contact_name_changed: ->
		@model.set("name", @input_contact_name.val())
		@save()
		
	save: ->
		if @model.isValid
			@model.save(
				{
					name: @model.get("name"), 
					contact_type_key: @model.get("contact_type_key")
				},
				{
					error: (model, errors) -> console.log errors
					success: (model) -> console.log "success"
				}
			)
		
	company_name_changed: ->
		console.log "company name changed"
		
	contact_type_clicked: ->
		@model.set("contact_type_key", @_contactTypesView.get_selected().model.get("pub_key"))
		@save()
		