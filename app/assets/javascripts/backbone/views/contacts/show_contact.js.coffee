class Quota.Views.ShowContact extends Backbone.View

	template: HandlebarsTemplates['contacts/show_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		# @contact_types = options.contact_types
		@companies = options.companies
		@_contactTypesView = null
		@_contactPhonesView = null
		@_contactEmailsView = null
		@_contactUrlsView = null
		@_contactAddressesView = null
		
	render: ->
		$(@el).html(@template({contact:@model.toJSON()}))
		
		# @container_contact_types = @$('#contact_types')
		@contact_company_name = @$('.company_name')
		
		# @_contactTypesView = new Quota.Views.ContactTypesToggles({contact:@model, collection:@contact_types, vent: @vent})
		# 		@container_contact_types.html(@_contactTypesView.render().el)
		# 		
		# @_companySelectView = new Quota.Views.CompanySelectView({contact:@model, collection:@companies, source: "name", val: "pub_key", className: 'string input-xlarge', vent: @vent})
		# 		@contact_company_name.html(@_companySelectView.render().el)
		
		@_contactPhonesView = new Quota.Views.ShowContactPhones({model:@model, collection:@model.phones, vent: vent})
		$('#contact_phones').html(@_contactPhonesView.render().el)
		
		# @_contactEmailsView = new Quota.Views.EditContactEmails({model:@model, collection:@model.emails, vent: vent})
		# 		$('#contact_emails').html(@_contactEmailsView.render().el)
		# 		
		# 		@_contactUrlsView = new Quota.Views.EditContactUrls({model:@model, collection:@model.urls, vent: vent})
		# 		$('#contact_urls').html(@_contactUrlsView.render().el)
		# 		
		# 		@_contactAddressesView = new Quota.Views.EditContactAddresses({model:@model, collection:@model.addresses, vent: vent})
		# 		$('#contact_addresses').html(@_contactAddressesView.render().el)
		@
