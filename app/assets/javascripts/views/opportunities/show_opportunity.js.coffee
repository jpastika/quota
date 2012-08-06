class Quota.Views.ShowOpportunity extends Quota.Views.PageBodyBlock

	template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@contacts = @model.get("contacts")
		@documents = @model.get("documents")
		
		@_contactsView = new Quota.Views.ShowOpportunityContacts({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@contacts, vent: @vent})
		@_documentsView = new Quota.Views.ShowOpportunityDocuments({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@documents, vent: @vent})
		
	render: ->
		$(@el).html(@template({opportunity:@model.toJSON()}))
		@container_contacts = @$('#contacts_container')
		@container_documents = @$('#documents_container')
		
		@_contactsView.setElement(@container_contacts).render()
		@_documentsView.setElement(@container_documents).render()
		@
