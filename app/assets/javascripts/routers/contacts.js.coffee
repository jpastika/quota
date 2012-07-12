class Quota.Routers.Contacts extends Backbone.Router
	routes:
		'contacts/new': 'new'
		'contacts/:id': 'show'
		'contacts/:id/edit': 'edit'
		'contacts': 'index'
	
	initialize: ->
		# @contact_types = new Quota.Collections.ContactTypes(gon.contact_types)
		# 		@contact_types.fetch()
		
		# @contacts = new Quote.Collections.Contacts()
		# 		@contacts.fetch()
		
	index: ->
		# alert "home page".
		
	show: (id) ->
		#alert "Quote #{id}"
		
	new: ->
		if gon
			@contact_types = new Quota.Collections.ContactTypes(gon.contact_types)
			@companies = new Quota.Collections.Companies(gon.companies)
		else
			@contact_types = new Quota.Collections.ContactTypes()
			@contact_types.fetch()
			@companies = new Quota.Collections.Companies()
			@companies.fetch()
		@contact = new Quota.Models.Contact()
		@contact_phones = @contact.phones
		
		view_contact = new Quota.Views.EditContact({model:@contact, contact_types: @contact_types, companies: @companies, vent: vent})
		# view_contact_phones = new Quota.Views.EditContactPhones({model:@contact, collection:@contact_phones, vent: vent})
		$('#contact').html(view_contact.render().el)
		# $('#contact_phones').html(view_contact_phones.render().el)
		
	edit: (id) ->
		if gon
			@contact_types = new Quota.Collections.ContactTypes(gon.contact_types)
			@companies = new Quota.Collections.Companies(gon.companies)
			@contact = new Quota.Models.Contact(gon.contact)
			@contact.phones.add(gon.contact_phones)
			@contact_phones = @contact.phones
		else
			@contact_types = new Quota.Collections.ContactTypes()
			@contact_types.fetch()
			@companies = new Quota.Collections.Companies()
			@companies.fetch()
			@contact = new Quota.Models.Contact({'pub_key':id})
			@contact.fetch()
			@contact_phones = @contact.phones
			@contact_phones.fetch()
		
		view_contact = new Quota.Views.EditContact({model:@contact, contact_types: @contact_types, companies: @companies, vent: vent})
		$('#contact').html(view_contact.render().el)
		