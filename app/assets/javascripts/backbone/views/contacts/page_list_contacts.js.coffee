class Quota.Views.PageListContacts extends Backbone.View
	
	# template: HandlebarsTemplates['contacts/page_list_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: "body"
	
	events:
		"click .add_contact": "handleAddContactClick"
		
		
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		# @contact_types = options.contact_types
		@contacts = options.contacts
		@vent.on("contact:clicked", @contactClicked, @)
		@vent.on("contact:save_new_successful", @contactAdded, @)
		@view = new Quota.Views.ListContacts({collection: @contacts, vent: @vent})
		@contactView = new Quota.Views.IndexContactAdd({model: new Quota.Models.Contact() , vent: @vent})
	
	render: ->
		$(@el).empty()
		$(@el).html(@template())
		
		@view.render()
		@contactView.render()
		@
		
	setup: ->
		@view = new Quota.Views.ListContacts({collection: @contacts, vent: @vent})
		@view.render()
		@contactView.render()
	
	contactClicked: (evt) ->
		@contactView = new Quota.Views.IndexContact({model: evt.model, vent: @vent})
		@contactView.render()
		
	handleAddContactClick: ->
		@contactView = new Quota.Views.IndexContactAdd({model: new Quota.Models.Contact() , vent: @vent})
		@contactView.render()
		
	contactAdded: (obj)->
		@contactView = new Quota.Views.IndexContact({model: obj, vent: @vent})
		@contactView.render()
		@contactView.handleEdit()