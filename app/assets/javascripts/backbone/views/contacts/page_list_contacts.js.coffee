class Quota.Views.PageListContacts extends Backbone.View
	
	# template: HandlebarsTemplates['contacts/page_list_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	
	# events:
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		# @contact_types = options.contact_types
		@contacts = options.contacts
		@vent.on('contact_link:clicked', @contactLinkClicked, @)
		@vent.on("contact:clicked", @contactClicked, @)
	
	render: ->
		$(@el).empty()
		$(@el).html(@template())
		view = new Quota.Views.ListContacts({collection: @contacts, vent: @vent})
		view.render()
		@
		
	setup: ->
		view = new Quota.Views.ListContacts({collection: @contacts, vent: @vent})
		view.render()
	
	contactLinkClicked: (evt) ->
		# enablePushState = true  
		# 		pushState = !!(enablePushState and window.history and window.history.pushState)
		# 		if pushState
		# 			# gon.contact = evt.view.model
		# 			Backbone.history.navigate("contacts/" + evt.view.model.get("pub_key") + "/edit", {trigger: true, replace: false})
		# 		else
		# window.location.replace(evt.view.model.url())
		
	contactClicked: (evt) ->
		contactView = new Quota.Views.IndexContact({model: evt.model, vent: @vent})
		contactView.render()