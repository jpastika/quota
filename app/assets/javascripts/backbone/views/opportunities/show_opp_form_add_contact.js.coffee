class Quota.Views.ShowOpportunityFormAddContact extends Backbone.View

	template: HandlebarsTemplates['opportunities/show_opp_form_add_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click #opportunity-add-new-contact-actions .btn-success": "clickAddNewContact"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_contact:clicked', @showAddContact, @)
		@vent.on('done_add_contact:clicked', @hideAddContact, @)
		@vent.on('companies:loaded', @companiesLoaded, @)
		@vent.on('company:changed', @companyChanged, @)
		@vent.on('opportunity_contacts:remove_contact', @removeOpportunityContact, @)
		@companies = options.companies
		# @companies = new Quota.Collections.Companies()
		#@companies.on('reset', @companiesReset, @)
		@vent.on('company_name:changed', @companyNameChanged, @)
		
		@opportunity = options.parent_model
		@opportunity_contacts = options.parent_collection
		
		@_companiesView = new Quota.Views.CompanySelect({parent_model:@opportunity, parent_child_key: @opportunity.get("company_key"), collection:@companies, field_name:"add_contact[company_key]", vent: @vent})
		@_contactsView = new Quota.Views.CompanyContactsAdd({parent_child_key: @opportunity.get("company_key"), vent: @vent, include_company:true, selected_contacts:@opportunity_contacts})
		
		@_companyComboView = new Quota.Views.CompanyComboView({parent_model:@opportunity, collection:@companies, source: "name", val: "pub_key", className: 'string span5', vent: @vent})
		
	render: ->
		$(@el).html(@template({opportunity:@opportunity}))
		@container_companies = @$('#companies_select')
		@container_contacts = @$('#company_contacts_container')
		@contact_company_name = @$('.company_name')
		@input_contact_name = @$('.contact_name input')
		@input_contact_company_name = @$('.company_name input')
		@input_contact_company_key = @$('.company_key')
		@input_contact_phone = @$('.contact_phone input')
		@input_contact_email = @$('.contact_email input')
		
		@loading = @$('.section-loading')
		
		company_name_field_name = @input_contact_company_name.attr('name')
		company_name_field_id = @input_contact_company_name.attr('id')
		
		@companiesLoaded()
		
		@
		
	show: ->
		$(@el).toggle(true)
		
	hide: ->
		$(@el).toggle(false)
		
	showAddContact: ->
		@show()
		
	hideAddContact: ->
		@hide()
	
	companiesReset: ->
		@vent.trigger('companies:loaded')
		@_companiesView.setElement(@container_companies).render()
		
	showLoading: ->
		@loading.toggle(true)

	hideLoading: ->
		@loading.toggle(false)
	
	companiesLoaded: ->
		@hideLoading
		@_contactsView.parent_model = _.first(@companies.where({pub_key: @opportunity.get("company_key")}))
		@_contactsView.setElement(@container_contacts).render()
		@_companyComboView.setElement(@contact_company_name).render()
		@_companiesView.setElement(@container_companies).render()
		
		
	companyChanged: (evt)->
		self = @
		
		@input_contact_company_name = @$('.company_name input')
		
		company = evt.company
		if company
			@model.set("company_key", company.get("pub_key"), {silent: true})
			@input_contact_company_key.val(company.get("pub_key"))
			@input_contact_company_name.val(company.get("name"))
			# @save()
		else
			@model.unset("company_key", {silent: true})
			@input_contact_company_key.val('')
			@input_contact_company_name.val('')
		
	companyNameChanged: (evt) ->
		self = @
		
		company = _.find(self.companies.models, (m) -> m.get("name") == evt.company_name)
		@input_contact_company_name = @$('.company_name input')
		
		if company
			@model.set("company_key", company.get("pub_key"), {silent: true})
			@input_contact_company_key.val(company.get("pub_key"))
			@input_contact_company_name.val(company.get("name"))
			# @save()
		else
			@model.unset("company_key", {silent: true})
			@input_contact_company_key.val('')
			# @input_contact_company_name.val('')
			
	clickAddNewContact: ->
		self = @
		contact = new Quota.Models.Contact()
		contact.save(
			{
				name: @input_contact_name.val()
				company_name: @$('#contact_company_name').val()
				company_key: @input_contact_company_key.val()
				contact_phone: @input_contact_phone.val()
				contact_email: @input_contact_email.val()
				# account_key: @opportunity.get("account_key")
			},
			{
				error: ->
					console.log "save error"
				success: (model) -> 
					self.resetAddNewContactForm()
					opportunity_contact = new Quota.Models.OpportunityContact({opportunity_key: self.opportunity.get("pub_key"), contact_key: model.get("pub_key")})
					opportunity_contact.save(
						{
							opportunity_key: opportunity_contact.get("opportunity_key")
							contact_key: opportunity_contact.get("contact_key")
						},
						{
							error: ->
								console.log "save error"
							success: (model) -> 
								self.opportunity_contacts.add(model)
								self.vent.trigger('company_contacts:add_new_contact_successful', {model: model})
								self._contactsView.contacts.add(model.get("contact"))
						}
					)
			}
		)
	
	removeOpportunityContact: (item)->
		@_contactsView.setElement(@container_contacts).render()
		
	resetAddNewContactForm: ->
		@input_contact_name.val('')
		@input_contact_company_name.val('')
		@input_contact_company_key.val(@opportunity.get("company_key"))
		@input_contact_phone.val('')
		@input_contact_email.val('')