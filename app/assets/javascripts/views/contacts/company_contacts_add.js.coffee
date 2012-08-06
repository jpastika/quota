class Quota.Views.CompanyContactsAdd extends Backbone.View

	template: HandlebarsTemplates['contacts/company_contacts_add'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	# events:
	# 		"change select": "companyChanged"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@parent_child_key = options.parent_child_key
		@_contactViews = []
		@contacts = new Quota.Collections.Contacts({url: '/api/companies/'+ @parent_child_key + '/contacts'})
		@vent.on('company:changed', @companyChanged, @)
		# @vent.on('add_contact', @addCompanyContact, @)
		@contacts.on('reset', @contactsReset, @)
		@contacts.fetch()
		# console.log @contacts.at[0].get("name")
		# @parent_model = options.parent_model
		# 		@parent_child_key = options.parent_child_key
		# 		@field_name = options.field_name
		# 		@collection.on('change', @render, @)
		
	render: ->
		$(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @contacts.models
		@$('#company_contacts').append(frag)
		@
	
	contactsReset: ->
		@render()
		
	companyChanged: (obj) ->
		@contacts.url='/api/companies/'+ obj.company.get("pub_key") + '/contacts'
		@contacts.fetch()
		
	addOne: (item)->
		view = new Quota.Views.CompanyContactAdd({model: item, contact: @model, vent: @vent})
		@_contactViews.push(view)
		view
	
	# addCompanyContact: (obj)->
	# 		console.log obj.contact.get("name")
