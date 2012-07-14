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
		
		view_contact = new Quota.Views.EditContact({model:@contact, contact_types: @contact_types, companies: @companies, vent: vent})
		$('#contact').html(view_contact.render().el)
		
	edit: (id) ->
		if gon
			@contact_types = new Quota.Collections.ContactTypes(gon.contact_types)
			@companies = new Quota.Collections.Companies(gon.companies)
			@contact = new Quota.Models.Contact(gon.contact)
			@contact.phones.add(gon.contact_phones)
			@contact.emails.add(gon.contact_emails)
			@contact.urls.add(gon.contact_urls)
			@contact.addresses.add(gon.contact_addresses)
		else
			@contact_types = new Quota.Collections.ContactTypes()
			@contact_types.fetch()
			@companies = new Quota.Collections.Companies()
			@companies.fetch()
			@contact = new Quota.Models.Contact({'pub_key':id})
			@contact.fetch()
		
		view_contact = new Quota.Views.EditContact({model:@contact, contact_types: @contact_types, companies: @companies, vent: vent})
		$('#contact').html(view_contact.render().el)