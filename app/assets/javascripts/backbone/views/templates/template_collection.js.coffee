class Quota.Views.TemplateCollection extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# el: '#contacts_container .section-table'
	
	events:
		"click .section-heading": "clickHeading"
		# "click #opportunity-contacts-actions>.btn-danger": "doneAddContactClicked"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@contents_container = options.contents_container
		
		# @companies = options.companies
		# 		@companies.on('add', @companyAdded, @)
		# 		# @collection = options.opportunity_contacts
		# 		@opportunity = options.parent_model
		# 		@parent_child_key = options.parent_child_key
		# 		
		# 		@_addContactView = new Quota.Views.ShowOpportunityFormAddContact({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @opportunity.get("pub_key"), vent: @vent, parent_collection: @collection, companies:@companies})
		# 		
		# 		@_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection, companies: @companies})
		# 		
		# 		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		# 		
		# 		@vent.on('company_contacts:add_contact', @addCompanyContact, @)
		# 		@vent.on('company_contacts:add_new_contact_successful', @addNewContact_Success, @)
		# 		@vent.on('opportunity_contacts:remove_contact', @removeOpportunityContact, @)
		
		
		
	render: ->
		# $(@el).html(@template({}))
		# @container_contact_list = @$('.section-table tbody')
		# 		@_contactsListView.setElement(@container_contact_list).render()
		# 		@container_add_contact = @$('.section-form')
		# 		@_addContactView.setElement(@container_add_contact).render()
		# 		
		@
		
	clickHeading: ->
		if @$('.section-heading i').hasClass('icon-caret-down')
			@$('.section-heading i').removeClass('icon-caret-down').addClass('icon-caret-up')
		else
			@$('.section-heading i').removeClass('icon-caret-up').addClass('icon-caret-down')
		
		@toggleContents()
	
	toggleContents: ->
		@$(@contents_container).toggle()
		
	# removeOpportunityContact: (item)->
	# 		@collection.remove(item)
	# 
	# 	hideAddBtn: ->
	# 		@$('#opportunity-contacts-actions>.btn-primary').toggle(false)
	# 
	# 	showAddBtn: ->
	# 		@$('#opportunity-contacts-actions>.btn-primary').toggle(true)
	# 
	# 	hideDoneLink: ->
	# 		@$('#opportunity-contacts-actions>.btn-danger').toggle(false)
	# 
	# 	showDoneLink: ->
	# 		@$('#opportunity-contacts-actions>.btn-danger').toggle(true)
	# 	
	# 	hideAddForm: ->
	# 		@$('.section-form').toggle(false)
	# 
	# 	showAddForm: ->
	# 		@$('.section-form').toggle(true)