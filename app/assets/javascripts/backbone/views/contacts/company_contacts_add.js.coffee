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
		@vent.on("company_contacts:add_contact_failed", @addCompanyContact_failed, @)
		# @vent.on('add_contact', @addCompanyContact, @)
		@contacts.on('reset', @contactsReset, @)
		@contacts.fetch()
		@include_company = options.include_company
		@selected_contacts = options.selected_contacts
		
	render: ->
		$(@el).html(@template({}))
		if @include_company && @parent_model && @selected_contacts.where({contact_key: @parent_model.get("pub_key")}).length == 0
			@appendOne(@addOne(@parent_model))
		@appendOne(@addOne(item)) for item in @contacts.models when @selected_contacts.where({contact_key: item.get("pub_key")}).length == 0
		
		if @parent_model && @$('#company_contacts tr').length == 0
			@$('#company_contacts').html('All contacts from '+ @parent_model.get("name") + ' have been added to opportunity.')
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
		# view
		frag = document.createDocumentFragment()
		frag.appendChild(view.render().el)
		frag
		
	appendOne: (frag)->
		@$('#company_contacts').append(frag)
		
	# addCompany: (item)->
	# 		view = new Quota.Views.CompanyContactAdd({model: item, vent: @vent})
	# 		@_contactViews.push(view)
	# 		view
	
	addCompanyContact: (obj)->
		# view = _.find(@_contactViews, (view) -> view.model == obj.contact).remove()
		# 		if view
		# 			view.remove()
		# 		@contacts.url='/api/companies/'+ @parent_model.get("pub_key") + '/contacts'
		# 		@contacts.fetch()
		# view = _.find(@_contactViews, (view) -> view.model == obj.contact).remove()
		# 	# console.log view
		# 	# 		view.remove()
		# 	if @$('#company_contacts div').length == 0
		# 		@$('#company_contacts').html('All contacts from '+ @parent_model.get("name") + ' have been added to opportunity.')
		# # 		console.log obj.contact.get("name")
	
	addCompanyContact_failed: (obj)->
		# @appendOne(@addOne(item)) for item in @contacts.models when @selected_contacts.where({contact_key: item.get("pub_key")}).length == 0
		# console.log @contacts
		# 		console.log @contacts.where({pub_key: obj.pub_key})[0]
		if obj.pub_key == @parent_model.get("pub_key")
			@appendOne(@addOne(@parent_model))
		else
			@appendOne(@addOne(@contacts.where({pub_key: obj.pub_key})[0]))
