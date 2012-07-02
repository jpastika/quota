class Quota.Routers.Contacts extends Backbone.Router
	routes:
		'contacts/new': 'new'
		'contacts/:id': 'show'
		'contacts/:id/edit': 'edit'
		'contacts': 'index'
	
	initialize: ->
		# @contact_types = new Quota.Collections.ContactTypes()
		# @contact_types.fetch()
		
	index: ->
		# alert "home page".
		
	show: (id) ->
		#alert "Quote #{id}"
		
	new: ->
		@contact = new Quota.Models.Contact()
		@contact_phones = @contact.phones
		
		view_contact_phones = new Quota.Views.New_ContactPhones({model:@contact, collection:@contact_phones})
		$('#contact_phones').html(view_contact_phones.render().el)
		
	edit: (id) ->
		@contact = new Quota.Models.Contact({'pub_key':id})
		@contact.fetch()
		@contact_phones = @contact.phones
		@contact_phones.fetch()
		
		view_contact_phones = new Quota.Views.Edit_ContactPhones({model:@contact, collection:@contact_phones})
		$('#contact_phones').html(view_contact_phones.render().el)