class Quota.Views.PageListContacts extends Backbone.View
	
	template: HandlebarsTemplates['contacts/page_list_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	
	# events:
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@contact_types = options.contact_types
		@contacts = options.contacts
		@vent.on('contact_link:clicked', @contactLinkClicked, @)
		
	render: ->
		$(@el).empty()
		$(@el).html(@template())
		view = new Quota.Views.ListContacts({collection: @contacts, contact_types: @contact_types, vent: @vent})
		@$('#contacts').append(view.render().el)
		@
	
	contactLinkClicked: (evt) ->
		# enablePushState = true  
		# 		pushState = !!(enablePushState and window.history and window.history.pushState)
		# 		if pushState
		# 			# gon.contact = evt.view.model
		# 			Backbone.history.navigate("contacts/" + evt.view.model.get("pub_key") + "/edit", {trigger: true, replace: false})
		# 		else
		window.location.replace(evt.view.model.url())