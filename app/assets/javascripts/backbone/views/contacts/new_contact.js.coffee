class Quota.Views.NewContact extends Backbone.View

	template: HandlebarsTemplates['contacts/editable_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"keydown .contact_company_name input": "companyNameChanged"
		"blur .contact_name input": "contactNameChanged"
		"blur .contact_title input": "contactTitleChanged"
	
	initialize: (options)->
		_.bindAll(@)
		Backbone.Validation.bind(
			@
			valid: (view, attr) ->
				# console.log "valid"
			invalid: (view, attr, error) ->
				console.log error
		)
		@vent = options.vent
		# @contact_types = options.contact_types
		# 		@_contactTypesView = null
		@model.on('change', @render, @)
		@vent.on('contact_type:clicked', @contactTypeClicked, @)
		@vent.on('contact_type:selected', @contactTypeSelected, @)
		
	render: ->
		console.log "new rendered"
		$(@el).html(@template({contact:@model.toJSON()}))
		
		@contact_name = @$('.contact_name');
		@contact_title = @$('.contact_title');
		@contact_company_name = @$('.company_name');
		@input_contact_name = @$('.contact_name input');
		@input_contact_title = @$('.contact_title input');
		@input_contact_company_name = @$('.company_name input');
		@input_contact_company_key = @$('.company_key');
		# @input_contact_type_key = @$('.contact_type_key');
		# 		@container_contact_types = @$('#contact_types');
		
		# @_contactTypesView = new Quota.Views.ContactTypesToggles({model:@model, collection:@contact_types, contact: @model, vent: @vent})
		# 		@container_contact_types.html(@_contactTypesView.render().el)
		@
		
	contactNameChanged: ->
		@model.set("name", @input_contact_name.val(), {silent: true})
		@save()
		
	contactTitleChanged: ->
		@model.set("title", @input_contact_title.val(), {silent: true})
		@save()

	save: ->
		# @model.set("contact_type_key", @_contactTypesView.getSelected().model.get("pub_key"), {silent: true})
		if @model.isValid(true)
			@model.save(
				{
					name: @model.get("name"), 
					title: @model.get("title")
				},
				{
					error: (model, errors) -> console.log errors
					success: (model) -> 
						if !@model.pub_key
							Backbone.history.navigate("contacts/" + model.get("pub_key") + "/edit", {trigger: false, replace: true})
					silent: true
				}
			)

	companyNameChanged: ->
		console.log "company name changed"

	contactTypeClicked: ->
		# @model.set("contact_type_key", @_contactTypesView.getSelected().model.get("pub_key"), {silent: true})
		# 		@setContactTypeRelatedFields()
		# 		@save()
	
	contactTypeSelected: ->
		# @setContactTypeRelatedFields()

	setContactTypeRelatedFields: ->
		self = @
		# ct = _.find self.contact_types.models, (cm) -> cm.get("pub_key") == self.model.get("contact_type_key")
		# 		if ct and ct.get("name") == "Company"
		# 			@contact_title.hide()
		# 			@contact_company_name.hide()
		# 			@input_contact_name.attr('placeholder', 'Company Name')
		# 		else
		# 			@contact_title.show()
		# 			@contact_company_name.show()
		# 			@input_contact_name.attr('placeholder', 'First Last')
	