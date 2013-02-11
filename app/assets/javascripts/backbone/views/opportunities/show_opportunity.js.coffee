class Quota.Views.ShowOpportunity extends Backbone.View

	# template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@opportunity_contacts = @model.get("opportunity_contacts")
		@documents = @model.get("documents")
		@companies = options.companies
		
		# @companies = new Quota.Collections.Companies()
		# 		@companies.on('reset', @companiesReset, @)
		# 		@companies.fetch()
		@_contactsView = new Quota.Views.ShowOpportunityContacts({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@opportunity_contacts, companies: @companies, vent: @vent})
		@_documentsView = new Quota.Views.ShowOpportunityDocuments({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@documents, vent: @vent})
		
	render: ->
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		@container_contacts = @$('#contacts_container')
		@container_documents = @$('#documents_container')
		
		@_contactsView.setElement(@container_contacts).render()
		@_documentsView.setElement(@container_documents).render()
		@
		
	setup: ->
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		@container_contacts = $('#contacts_container')
		@container_documents = $('#documents_container')

		@_contactsView.setElement(@container_contacts).render()
		@_documentsView.setElement(@container_documents).render()
		
	companiesReset: ->
		@_contactsView.setElement(@container_contacts).render()