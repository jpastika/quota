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
		@contacts = new Quota.Collections.Contacts()
		@contacts.url='/api/companies/'+ @parent_child_key + '/contacts'
		@vent.on('company:changed', @companyChanged, @)
		@vent.on('company_contacts:add_contact', @addCompanyContact, @)
		# @vent.on('add_contact', @addCompanyContact, @)
		@contacts.on('reset', @contactsReset, @)
		@contacts.fetch()
		@include_company = options.include_company
		@selected_contacts = options.selected_contacts
		
		# console.log @contacts.at[0].get("name")
		# @parent_model = options.parent_model
		# 		@parent_child_key = options.parent_child_key
		# 		@field_name = options.field_name
		# 		@collection.on('change', @render, @)
		
	render: ->
		$(@el).html(@template({}))
		if @include_company && @parent_model && @selected_contacts.where({contact_key: @parent_model.get("pub_key")}).length == 0
			frag = document.createDocumentFragment()
			frag.appendChild(@addOne(@parent_model).render().el)
			@$('#company_contacts').append(frag)
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @contacts.models when @selected_contacts.where({contact_key: item.get("pub_key")}).length == 0
		@$('#company_contacts').append(frag)
		@
	
	contactsReset: ->
		@render()
		
	companyChanged: (obj) ->
		@parent_model = obj.company
		@contacts.url='/api/companies/'+ obj.company.get("pub_key") + '/contacts'
		@contacts.fetch()
		
	addOne: (item)->
		view = new Quota.Views.CompanyContactAdd({model: item, vent: @vent})
		@_contactViews.push(view)
		view
		
	# addCompany: (item)->
	# 		view = new Quota.Views.CompanyContactAdd({model: item, vent: @vent})
	# 		@_contactViews.push(view)
	# 		view
	
	addCompanyContact: (obj)->
		view = _.find(@_contactViews, (view) -> view.model == obj.contact)
		view.remove()
	# 		console.log obj.contact.get("name")
