class Quota.Views.ShowOpportunityFormAddContact extends Quota.Views.SidebarBodyBlock

	template: HandlebarsTemplates['opportunities/show_opp_form_add_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_contact:clicked', @showAddContact, @)
		@vent.on('done_add_contact:clicked', @hideAddContact, @)
		@vent.on('companies:loaded', @companiesLoaded, @)
		@vent.on('company:changed', @companyChanged, @)
		@companies = new Quota.Collections.Companies()
		@companies.on('reset', @companiesReset, @)
		
		@opportunity = options.parent_model
		@_companiesView = new Quota.Views.CompanySelect({parent_model:@opportunity, parent_child_key: @opportunity.get("company_key"), collection:@companies, field_name:"add_contact[company_key]", vent: @vent})
		@_contactsView = new Quota.Views.CompanyContactsAdd({parent_model:@opportunity, parent_child_key: @opportunity.get("company_key"), vent: @vent})
		
	render: ->
		$(@el).html(@template({opportunity:@opportunity}))
		@container_companies = @$('#companies_select')
		@container_contacts = @$('#company_contacts')
		@loading = @$('.section-loading')
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
		@_contactsView.setElement(@container_contacts).render()
		
	companyChanged: (evt)->
		@_contactsView.setElement(@container_contacts).render()
		
		
