class Quota.Routers.Contacts extends Backbone.Router
	routes:
		'contacts/new': 'new'
		'contacts/:id': 'show'
		'contacts/:id/edit': 'edit'
		'contacts': 'index'
	
	initialize: ->
		@contact_types = new Quota.Collections.ContactTypes()
		@contact_types.fetch()
		
	index: ->
		# alert "home page".
		
	show: (id) ->
		#alert "Quote #{id}"
		
	new: ->
		@contact = new Quota.Models.Contact()
		@contact_phones = @contact.phones
		
		view_contact = new Quota.Views.NewContact({model:@contact, contact_types: @contact_types, vent: vent})
		view_contact_phones = new Quota.Views.NewContactPhones({model:@contact, collection:@contact_phones, vent: vent})
		$('#contact').html(view_contact.render().el)
		$('#contact_phones').html(view_contact_phones.render().el)
		
	edit: (id) ->
		@contact = new Quota.Models.Contact({'pub_key':id})
		@contact.fetch()
		@contact_phones = @contact.phones
		@contact_phones.fetch()
		
		view_contact = new Quota.Views.EditContact({model:@contact, contact_types: @contact_types, vent: vent})
		view_contact_phones = new Quota.Views.EditContactPhones({model:@contact, collection:@contact_phones, vent: vent})
		$('#contact').html(view_contact.render().el)
		$('#contact_phones').html(view_contact_phones.render().el)