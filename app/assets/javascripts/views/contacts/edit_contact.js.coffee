class Quota.Views.EditContact extends Backbone.View

	template: HandlebarsTemplates['contacts/editable_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"blur .contact_name input": "contactNameChanged"
		"blur .contact_title input": "contactTitleChanged"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		Backbone.Validation.bind(
			@
			valid: (view, attr) ->
				self.clearError(attr)
			invalid: (view, attr, error) ->
				self.clearError(attr)
				self.handleError(attr, error)
		)
		@vent = options.vent
		@contact_types = options.contact_types
		@companies = options.companies
		@_contactTypesView = null
		@_contactPhonesView = null
		@model.on('change', @render, @)
		@vent.on('contact_type:clicked', @contactTypeClicked, @)
		@vent.on('contact_type:selected', @contactTypeSelected, @)
		@vent.on('company_name:changed', @companyNameChanged, @)
		
	render: ->
		$(@el).html(@template({contact:@model.toJSON()}))
		
		@contact_name = @$('.contact_name');
		@contact_title = @$('.contact_title');
		@contact_company_name = @$('.company_name');
		@input_contact_name = @$('.contact_name input');
		@input_contact_title = @$('.contact_title input');
		@input_contact_company_key = @$('.company_key');
		@input_contact_type_key = @$('.contact_type_key');
		@container_contact_types = @$('#contact_types');
		
		@_contactTypesView = new Quota.Views.ContactTypesToggles({contact:@model, collection:@contact_types, vent: @vent})
		@container_contact_types.html(@_contactTypesView.render().el)
		
		@_companySelectView = new Quota.Views.CompanySelectView({contact:@model, collection:@companies, source: "name", val: "pub_key", className: 'string input-xlarge', vent: @vent})
		@contact_company_name.html(@_companySelectView.render().el)
		
		@_contactPhonesView = new Quota.Views.EditContactPhones({model:@model, collection:@model.phones, vent: vent})
		$('#contact_phones').html(@_contactPhonesView.render().el)
		
		@input_contact_company_name = @$('.company_name input');
		@
		
	contactNameChanged: ->
		@model.set("name", @input_contact_name.val(), {silent: true})
		@save()
		
	contactTitleChanged: ->
		@model.set("title", @input_contact_title.val(), {silent: true})
		@save()
		
	save: ->
		self = @
		modelid = @model.id
		@model.set("contact_type_key", @_contactTypesView.getSelected().model.get("pub_key"), {silent: true})
		if @model.isValid(true)
			@model.save(
				{
					name: @model.get("name")
					title: @model.get("title")
					contact_type_key: @model.get("contact_type_key")
					company_key: @model.get("company_key")
				},
				{
					error: @handleError
					success: (model) -> 
						if modelid != model.id
							Backbone.history.navigate("contacts/" + model.get("pub_key") + "/edit", {trigger: false, replace: true})
							console.log self.model.phones.models
							_.each(self._contactPhonesView._phoneViews, (v) -> if v.model.hasChanged() and v.model.isValid(true) then v.save())
					silent: true
				}
			)
	
	handleSaveErrors: (model, response) ->
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for atttribute, messages of errors
				self.handleError(attribute, message)
	
	handleError: (attribute, message) ->
		@$el.find(".control-group.#{attribute}").addClass('error').find('.controls').append("<span class=\"help-inline\">#{message}</span>")
	
	clearError: (attribute) ->
		@$el.find(".control-group.#{attribute}").removeClass('error').find('.help-inline').remove()
				
	companyNameChanged: (evt) ->
		self = @
		company = _.find(self.companies.models, (m) -> m.get("name") == evt.company_name)
		if company
			@model.set("company_key", company.get("pub_key"), {silent: true})
			@save()
		else
			@model.unset("company_key", {silent: true})
			if evt.company_name != ''
				company = new Quota.Models.Contact()
				company.save(
					{
						name: evt.company_name
						contact_type_key: _.first(self.contact_types.where({name: "Company"})).get("pub_key")
					},{
						error: (model, response) ->
							self.handleError(model, response)
						success: (model) ->
							self.companies.add(model)
							self._companySelectView.remove()
							self.model.set("company_key", model.get("pub_key"), {silent: true})
							self._companySelectView = new Quota.Views.CompanySelectView({contact:self.model, collection:self.companies, source: "name", val: "pub_key", className: 'string input-xlarge', vent: self.vent})
							self.contact_company_name.html(self._companySelectView.render().el)
							self.save()
					}
				)
			else
				@save()

	contactTypeClicked: ->
		if @model.get("contact_type_key") != @_contactTypesView.getSelected().model.get("pub_key")
			@model.unset("company_key", {silent: true})
			@_companySelectView.$el.attr('value', '')
			@model.set("contact_type_key", @_contactTypesView.getSelected().model.get("pub_key"), {silent: true})
		
			@setContactTypeRelatedFields()
			@save()
	
	contactTypeSelected: ->
		@setContactTypeRelatedFields()
		
	setContactTypeRelatedFields: ->
		self = @
		ct = _.find self.contact_types.models, (cm) -> cm.get("pub_key") == self.model.get("contact_type_key")
		if ct and ct.get("name") == "Company"
			@contact_title.hide()
			@contact_company_name.hide()
			@input_contact_name.attr('placeholder', 'Company Name')
		else
			@contact_title.show()
			@contact_company_name.show()
			@input_contact_name.attr('placeholder', 'First Last')
		