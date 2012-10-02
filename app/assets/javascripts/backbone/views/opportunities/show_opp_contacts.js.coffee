class Quota.Views.ShowOpportunityContacts extends Backbone.View

	
	template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click #opportunity-contacts-actions>.btn-primary": "addContactClicked"
		"click #opportunity-contacts-actions>.btn-danger": "doneAddContactClicked"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@companies = options.companies
		@companies.on('add', @companyAdded, @)
		# @collection = options.opportunity_contacts
		@opportunity = options.parent_model
		@parent_child_key = options.parent_child_key
		
		@_addContactView = new Quota.Views.ShowOpportunityFormAddContact({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @opportunity.get("pub_key"), vent: @vent, parent_collection: @collection, companies:@companies})
		
		@_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection, companies: @companies})
		
		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@vent.on('company_contacts:add_contact', @addCompanyContact, @)
		@vent.on('company_contacts:add_new_contact_successful', @addNewContact_Success, @)
		
		
	render: ->
		$(@el).html(@template({}))
		@container_contact_list = @$('.section-table')
		@_contactsListView.setElement(@container_contact_list).render()
		# @_contactsListView.setElement(@container_contact_list).render().hide()
		# @_addContactView.companies.fetch()
		# frag = document.createDocumentFragment()
		# 		frag.appendChild(@_contactsListView.render().el)
		# 		@$('.section-table').append(frag)
		# 		
		@container_add_contact = @$('.section-form')
		@_addContactView.setElement(@container_add_contact).render().hide()
		# @_addContactView.companies.fetch()
		
		@hideDoneLink()
		
		@
	
	companyAdded: ->
		@_addContactView.setElement(@container_add_contact).render()
	
	addContactClicked: ->
		@vent.trigger('add_contact:clicked')
		@_addContactView.resetAddNewContactForm()
		@hideAddBtn()
		@showDoneLink()
		@showAddForm()
		

	doneAddContactClicked: ->
		@vent.trigger('done_add_contact:clicked')
		@_addContactView.resetAddNewContactForm()
		@hideDoneLink()
		@showAddBtn()
		@hideAddForm()
		

	hideAddBtn: ->
		@$('#opportunity-contacts-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#opportunity-contacts-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#opportunity-contacts-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#opportunity-contacts-actions>.btn-danger').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)