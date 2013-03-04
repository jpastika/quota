class Quota.Views.EditDocument extends Backbone.View

	# template: HandlebarsTemplates['opportunities/edit_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .document_company_phone ul li": "companyPhoneClicked"
		"click .document_company_fax ul li": "companyFaxClicked"
		"click .document_contact_phone ul li": "contactPhoneClicked"
		"click .document_contact_email ul li": "contactEmailClicked"
		"click .document_contact_name ul li": "contactNameClicked"
		"click .document_billing_street1 ul li": "billingAddressClicked"
		"click .document_shipping_street1 ul li": "shippingAddressClicked"
		"click .same_as_billing": "sameAsBillingClicked"
		"keydown .document_contact_name input": "handleKeyDownContact"
		"keydown .document_company_name input": "handleKeyDownCompany"
		
		# "blur #opportunity_estimated_close_dp": "checkEstimatedCloseDate"
		# 	"blur #opportunity_actual_close_dp": "checkActualCloseDate"
		# 	"blur #opportunity_actual_cancel_dp": "checkActualCancelDate"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		# Backbone.Validation.bind(
		# 			@
		# 			valid: (view, attr) ->
		# 				self.clearError(attr)
		# 			invalid: (view, attr, error) ->
		# 				self.clearError(attr)
		# 				self.handleError(attr, error)
		# 		)
		@companies = options.companies
		@contacts = options.contacts
		
		@el = options.el
		@vent = options.vent
		
		# console.log @companies.models
		
		@_companyComboView = new Quota.Views.CompanyComboView({parent_model:@model, collection:@companies, source: "name", val: "pub_key", className: 'string span10', vent: @vent})
			
		# @_companyComboView = new Quota.Views.CompanyComboView({parent_model:@model, source: "name", val: "pub_key", className: 'string span10', vent: @vent})
			
		@_contactComboView = new Quota.Views.ContactComboView({parent_model:@model, collection:@contacts, source: "name", val: "pub_key", company_key: @model.get("company_key"), className: 'string span10', vent: @vent})
		
		# @model.on('change', @render, @)
		@vent.on('company_combo:item_selected', @companyNameChanged, @)
		@vent.on('contact_name:changed', @contactNameChanged, @)
		
	render: ->
		self = @
		@document_name = @$('.document_name')
		@document_company_name = @$('.document_company_name div span')
		@document_contact_name = @$('.document_contact_name div span')
		@document_company_phone = @$('.document_company_phone')
		@document_company_phone_dropdown_toggle = @$('.document_company_phone .dropdown-toggle')
		@document_company_phone_dropdown_list = @$('.document_company_phone ul')
		@document_company_fax = @$('.document_company_fax')
		@document_company_fax_dropdown_toggle = @$('.document_company_fax .dropdown-toggle')
		@document_company_fax_dropdown_list = @$('.document_company_fax ul')
		@document_contact_dropdown_toggle = @$('.document_contact_name .dropdown-toggle')
		@document_contact_dropdown_list = @$('.document_contact_name ul')
		@document_contact_phone = @$('.document_contact_phone')
		@document_contact_phone_dropdown_toggle = @$('.document_contact_phone .dropdown-toggle')
		@document_contact_phone_dropdown_list = @$('.document_contact_phone ul')
		@document_contact_email = @$('.document_company_phone')
		@document_contact_email_dropdown_toggle = @$('.document_contact_email .dropdown-toggle')
		@document_contact_email_dropdown_list = @$('.document_contact_email ul')
		@document_billing_street1 = @$('.document_billing_street1')
		@document_billing_address_dropdown_toggle = @$('.document_billing_street1 .dropdown-toggle')
		@document_billing_address_dropdown_list = @$('.document_billing_street1 ul')
		@document_shipping_street1 = @$('.document_shipping_street1')
		@document_shipping_address_dropdown_toggle = @$('.document_shipping_street1 .dropdown-toggle')
		@document_shipping_address_dropdown_list = @$('.document_shipping_street1 ul')
		@input_document_name = @$('.document_name input')
		@input_document_po = @$('.document_po input')
		@input_document_company_name = @$('.document_company_name input')
		@input_document_company_phone = @$('.document_company_phone input')
		@input_document_company_phone_label = @$('.document_company_phone label')
		@input_document_company_fax = @$('.document_company_fax input')
		@input_document_contact_name = @$('.document_contact_name input')
		@input_document_contact_phone = @$('.document_contact_phone input')
		@input_document_contact_email = @$('.document_contact_email input')
		@input_document_billing_street1 = @$('.document_billing_street1 input')
		@input_document_billing_street2 = @$('.document_billing_street2 input')
		@input_document_billing_city = @$('.document_billing_city')
		@input_document_billing_state = @$('.document_billing_state')
		@input_document_billing_zip = @$('.document_billing_zip')
		@input_document_billing_country = @$('.document_billing_country input')
		@input_document_shipping_street1 = @$('.document_shipping_street1 input')
		@input_document_shipping_street2 = @$('.document_shipping_street2 input')
		@input_document_shipping_city = @$('.document_shipping_city')
		@input_document_shipping_state = @$('.document_shipping_state')
		@input_document_shipping_zip = @$('.document_shipping_zip')
		@input_document_shipping_country = @$('.document_shipping_country input')
		@input_document_notes_customer = @$('.document_notes_customer textarea')
		@input_document_notes_internal = @$('.document_notes_internal textarea')
		@input_document_company_key = @$('#document_company_key')
		@input_document_contact_key = @$('#document_contact_key')
		
		# company_name_field_name = @input_document_company_name.attr('name')
		# 		company_name_field_id = @input_document_company_name.attr('id')
		# 		
		# 		@_companyComboView.setElement(@document_company_name).render()
		# 		# @opportunity_company_name.html(@_companySelectView.render().el)
		# 		
		# 		@input_document_company_name = @$('.document_company_name input')
		# 		
		# 		@input_document_company_name.attr('name', company_name_field_name)
		# 		@input_document_company_name.attr('id', company_name_field_id)
		
		@_companyComboView.el = @input_document_company_name
		@_companyComboView.render()
		
		
		
		
		contact_name_field_name = @input_document_contact_name.attr('name')
		contact_name_field_id = @input_document_contact_name.attr('id')
		
		@_contactComboView.setElement(@document_contact_name).render()
		# @opportunity_company_name.html(@_companySelectView.render().el)
		
		@input_document_contact_name = @$('.document_contact_name input')
		
		@input_document_contact_name.attr('name', contact_name_field_name)
		@input_document_contact_name.attr('id', contact_name_field_id)
		
		@vent.trigger("document:rendered")
		@
		
	setup: ->
		self = @
		@document_name = @$('.document_name')
		@document_company_name = @$('.document_company_name div span')
		@document_contact_name = @$('.document_contact_name div span')
		@document_company_phone = @$('.document_company_phone')
		@document_company_phone_dropdown_toggle = @$('.document_company_phone .dropdown-toggle')
		@document_company_phone_dropdown_list = @$('.document_company_phone ul')
		@document_company_fax = @$('.document_company_fax')
		@document_company_fax_dropdown_toggle = @$('.document_company_fax .dropdown-toggle')
		@document_company_fax_dropdown_list = @$('.document_company_fax ul')
		@document_contact_dropdown_toggle = @$('.document_contact_name .dropdown-toggle')
		@document_contact_dropdown_list = @$('.document_contact_name ul')
		@document_contact_phone = @$('.document_contact_phone')
		@document_contact_phone_dropdown_toggle = @$('.document_contact_phone .dropdown-toggle')
		@document_contact_phone_dropdown_list = @$('.document_contact_phone ul')
		@document_contact_email = @$('.document_company_phone')
		@document_contact_email_dropdown_toggle = @$('.document_contact_email .dropdown-toggle')
		@document_contact_email_dropdown_list = @$('.document_contact_email ul')
		@document_billing_street1 = @$('.document_billing_street1')
		@document_billing_address_dropdown_toggle = @$('.document_billing_street1 .dropdown-toggle')
		@document_billing_address_dropdown_list = @$('.document_billing_street1 ul')
		@document_shipping_street1 = @$('.document_shipping_street1')
		@document_shipping_address_dropdown_toggle = @$('.document_shipping_street1 .dropdown-toggle')
		@document_shipping_address_dropdown_list = @$('.document_shipping_street1 ul')
		@input_document_name = @$('.document_name input')
		@input_document_po = @$('.document_po input')
		@input_document_company_name = @$('.document_company_name input')
		@input_document_company_phone = @$('.document_company_phone input')
		@input_document_company_phone_label = @$('.document_company_phone label')
		@input_document_company_fax = @$('.document_company_fax input')
		@input_document_contact_name = @$('.document_contact_name input')
		@input_document_contact_phone = @$('.document_contact_phone input')
		@input_document_contact_email = @$('.document_contact_email input')
		@input_document_billing_street1 = @$('.document_billing_street1 input')
		@input_document_billing_street2 = @$('.document_billing_street2 input')
		@input_document_billing_city = @$('.document_billing_city')
		@input_document_billing_state = @$('.document_billing_state')
		@input_document_billing_zip = @$('.document_billing_zip')
		@input_document_billing_country = @$('.document_billing_country input')
		@input_document_shipping_street1 = @$('.document_shipping_street1 input')
		@input_document_shipping_street2 = @$('.document_shipping_street2 input')
		@input_document_shipping_city = @$('.document_shipping_city')
		@input_document_shipping_state = @$('.document_shipping_state')
		@input_document_shipping_zip = @$('.document_shipping_zip')
		@input_document_shipping_country = @$('.document_shipping_country input')
		@input_document_notes_customer = @$('.document_notes_customer textarea')
		@input_document_notes_internal = @$('.document_notes_internal textarea')
		@input_document_company_key = @$('#document_company_key')
		@input_document_contact_key = @$('#document_contact_key')
		
		# company_name_field_name = @input_document_company_name.attr('name')
		# 		company_name_field_id = @input_document_company_name.attr('id')
		# 		
		# 		@_companyComboView.setElement(@document_company_name).render()
		# 		# @opportunity_company_name.html(@_companySelectView.render().el)
		# 		
		# 		@input_document_company_name = @$('.document_company_name input')
		# 		
		# 		@input_document_company_name.attr('name', company_name_field_name)
		# 		@input_document_company_name.attr('id', company_name_field_id)
		
		@_companyComboView.el = @input_document_company_name
		@_companyComboView.render()
		
		contact_name_field_name = @input_document_contact_name.attr('name')
		contact_name_field_id = @input_document_contact_name.attr('id')
		
		@_contactComboView.setElement(@document_contact_name).render()
		# @opportunity_company_name.html(@_companySelectView.render().el)
		
		@input_document_contact_name = @$('.document_contact_name input')
		
		@input_document_contact_name.attr('name', contact_name_field_name)
		@input_document_contact_name.attr('id', contact_name_field_id)
		@vent.trigger("document:rendered")
		
		if @model.get("company_key")
			@company = _.find(self.companies.models, (m) -> m.get("pub_key") == self.model.get("company_key"))
			
			if @company
				company_phones = @company.get("phones")
				addresses = @company.get("addresses")
				phones = _.filter(company_phones, (m) -> m.name.toLowerCase().indexOf("fax") == -1)
				faxes = _.filter(company_phones, (m) -> m.name.toLowerCase().indexOf("fax") != -1)
				contacts = @getCompanyContacts(@company.get("pub_key"))

				if phones.length
					@setupCompanyPhonesDropDown(phones)
				if faxes.length
					@setupCompanyFaxesDropDown(faxes)
				if addresses.length
					@setupBillingAddressesDropDown(addresses)
					@setupShippingAddressesDropDown(addresses)
				if contacts.length
					@setupCompanyContactsDropDown(contacts)
			
		if @model.get("contact_key")
			@contact = _.find(self.contacts.models, (m) -> m.get("pub_key") == self.model.get("contact_key"))
			
			if @contact
				contact_phones = @contact.get("phones")
				c_phones = _.filter(contact_phones, (m) -> m.name.toLowerCase().indexOf("fax") == -1)
				emails = @contact.get("emails")

				if c_phones.length
					@setupContactPhonesDropDown(c_phones)
				if emails.length
					@setupContactEmailsDropDown(emails)
		
	rendered: ->
		
	save: ->
	
	handleSaveErrors: (model, response) ->
		
	handleError: (attribute, message) ->
		
	clearError: (attribute) ->
				
	companyNameChanged: (evt) ->
		self = @
		console.log evt.company.name
		@company = _.find(self.companies.models, (m) -> m.get("name").toLowerCase() == evt.company.name.toLowerCase())
		if @company
			@model.set({company_key: @company.get("pub_key"), silent: true})
			@input_document_company_key.val(@company.get("pub_key"))
			# @save()
		else
			@company = null
			@model.set({company_key: '', silent: true})
			@input_document_company_key.val('')
		self.handleCompanyChanged()
		self.vent.trigger("company_key:changed", {company_key: @input_document_company_key.val()})


	contactNameChanged: (evt) ->
		self = @
		@contact = _.find(self.contacts.models, (m) -> m.get("name") == evt.contact_name)
		if @contact
			@model.set({contact_key: @contact.get("pub_key"), silent: true})
			@input_document_contact_key.val(@contact.get("pub_key"))
			company = _.find(self.companies.models, (m) -> m.get("pub_key") == self.contact.get("company_key"))
		
			if company
				if @company != company
					@company = company
					@model.set({company_key: @company.get("pub_key"), silent: true})
					@input_document_company_key.val(@company.get("pub_key"))
					@input_document_company_name.val(@company.get("name"))
					@clearCompanyFields()
					@setupCompanyFields()
					contacts = @getCompanyContacts(@company.get("pub_key"))
					@setupCompanyContactsDropDown(contacts)
			else
				@company = null
				@model.set({company_key: '', silent: true})
				@input_document_company_key.val('')
				@input_document_company_name.val('')
				@clearCompanyFields()
				@setupCompanyFields()
				contacts = new Array()
				@setupCompanyContactsDropDown(contacts)
			# @save()
		else
			@contact = null
			@model.set({contact_key: '', silent: true})
			@input_document_contact_key.val('')
		self.handleContactChanged()
		self.vent.trigger("contact_key:changed", {company_key: @input_document_contact_key.val()})
			
	handleCompanyChanged: ->
		@clearContact()
		@clearCompanyFields()
		if @company
			@setupCompanyFields()
			@setupCompanyContacts()
		
	handleContactChanged: ->
		@clearContactFields()
		if @contact
			@setupContactFields()
			
	handleKeyDownCompany: (evt) ->
		if evt.keyCode != 9
			@resetCompany()

	handleKeyDownContact: (evt) ->
		if evt.keyCode != 9
			@resetContact()

	resetCompany: ->
		@company = null
		@input_document_company_key.val('')
		@clearCompanyFields()
		@clearContactFields()

	resetContact: ->
		@contact = null
		@input_document_contact_key.val('')
		@clearContactFields()
	
	setupCompanyFields: ->
		company_phones = @company.get("phones")
		addresses = @company.get("addresses")
		phones = _.filter(company_phones, (m) -> m.name.toLowerCase().indexOf("fax") == -1)
		faxes = _.filter(company_phones, (m) -> m.name.toLowerCase().indexOf("fax") != -1)
		
		if phones.length
			phone = phones[0]
			@input_document_company_phone.val(phone.val)
			@setupCompanyPhonesDropDown(phones)
		if faxes.length
			fax = faxes[0]
			@input_document_company_fax.val(fax.val)
			@setupCompanyFaxesDropDown(faxes)
		if addresses.length
			address = addresses[0]
			@setBillingAddress(address)
			@setShippingAddress(address)
			@setupBillingAddressesDropDown(addresses)
			@setupShippingAddressesDropDown(addresses)
			
	setBillingAddress: (address)->
		@input_document_billing_street1.val(address.street1)
		@input_document_billing_street2.val(address.street2)
		@input_document_billing_city.val(address.city)
		@input_document_billing_state.val(address.state)
		@input_document_billing_zip.val(address.zip)
		@input_document_billing_country.val(address.country)
	
	setShippingAddress: (address)->
		@input_document_shipping_street1.val(address.street1)
		@input_document_shipping_street2.val(address.street2)
		@input_document_shipping_city.val(address.city)
		@input_document_shipping_state.val(address.state)
		@input_document_shipping_zip.val(address.zip)
		@input_document_shipping_country.val(address.country)

	setupCompanyPhonesDropDown: (phones)->
		self = @
		@document_company_phone_dropdown_toggle.show()
		_.each(phones, (m) -> self.document_company_phone_dropdown_list.append("<li data-attr=#{m.val}>#{m.val}</li>"))
		
	setupCompanyFaxesDropDown: (faxes)->
		self = @
		@document_company_fax_dropdown_toggle.show()
		_.each(faxes, (m) -> self.document_company_fax_dropdown_list.append("<li data-attr=#{m.val}>#{m.val}</li>"))
		
	setupBillingAddressesDropDown: (addresses)->
		self = @
		@document_billing_address_dropdown_toggle.show()
		_.each(addresses, (m) -> 
			a = "<li data-attr=#{m.pub_key}>"
			if m.street1
				a += "<div data-attr=#{m.pub_key}>#{m.street1}</div>"
			if m.street2
				a += "<div data-attr=#{m.pub_key}>#{m.street2}</div>"
			a += "<div data-attr=#{m.pub_key}>"
			if m.city
				a += "#{m.city}"
			if m.state
				a += " #{m.state}"
			if m.zip
				a += " #{m.zip}"
			a += "</div>"
			if m.country
				a += "<div data-attr=#{m.pub_key}>#{m.country}</div>"
			a += "</li>"
			self.document_billing_address_dropdown_list.append(a)
		)

	setupShippingAddressesDropDown: (addresses)->
		self = @
		@document_shipping_address_dropdown_toggle.show()
		_.each(addresses, (m) ->  
			a = "<li data-attr=#{m.pub_key}>"
			if m.street1
				a += "<div data-attr=#{m.pub_key}>#{m.street1}</div>"
			if m.street2
				a += "<div data-attr=#{m.pub_key}>#{m.street2}</div>"
			a += "<div data-attr=#{m.pub_key}>"
			if m.city
				a += "#{m.city}"
			if m.state
				a += " #{m.state}"
			if m.zip
				a += " #{m.zip}"
			a += "</div>"
			if m.country
				a += "<div data-attr=#{m.pub_key}>#{m.country}</div>"
			a += "</li>"
			self.document_shipping_address_dropdown_list.append(a)
		)

	setupCompanyContacts: ->
		contacts = @getCompanyContacts(@company.get("pub_key"))
		
		if contacts.length
			contact = contacts[0]
			@contact = contact
			@input_document_contact_key.val(@contact.get("pub_key"))
			@input_document_contact_name.val(@contact.get("name"))
			
			@handleContactChanged()
			@setupCompanyContactsDropDown(contacts)
	
	setupCompanyContactsDropDown: (contacts)->
		self = @
		@document_contact_dropdown_toggle.show()
		_.each(contacts, (m) -> self.document_contact_dropdown_list.append("<li data-attr=#{m.get("pub_key")}>#{m.get("name")}</li>"))

	setupContactFields: ->
		contact_phones = @contact.get("phones")
		phones = _.filter(contact_phones, (m) -> m.name.toLowerCase().indexOf("fax") == -1)
		emails = @contact.get("emails")
		
		if phones.length
			phone = phones[0]
			@input_document_contact_phone.val(phone.val)
			@setupContactPhonesDropDown(phones)
		if emails.length
			email = emails[0]
			@input_document_contact_email.val(email.val)
			@setupContactEmailsDropDown(emails)
	
	setupContactPhonesDropDown: (phones)->
		self = @
		@document_contact_phone_dropdown_toggle.show()
		_.each(phones, (m) -> self.document_contact_phone_dropdown_list.append("<li data-attr=#{m.val}>#{m.val}</li>"))

	setupContactEmailsDropDown: (emails)->
		self = @
		@document_contact_email_dropdown_toggle.show()
		_.each(emails, (m) -> self.document_contact_email_dropdown_list.append("<li data-attr=#{m.val}>#{m.val}</li>"))

	clearCompany: ->
		@input_document_company_name.val('')
		
	clearContact: ->
		@input_document_contact_name.val('')
		
	clearCompanyFields: ->
		@input_document_company_phone.val('')
		@input_document_company_fax.val('')
		@clearAddressFields()
		@clearCompanyPhonesDropDown()
		@clearCompanyFaxDropDown()
		@clearCompanyContactDropDown()
		
	clearAddressFields: ->
		@clearBillingAddressFields()
		@clearBillingAddressDropDown()
		@clearShippingAddressFields()
		@clearShippingAddressDropDown()
		
	clearBillingAddressFields: ->
		@input_document_billing_street1.val('')
		@input_document_billing_street2.val('')
		@input_document_billing_city.val('')
		@input_document_billing_state.val('')
		@input_document_billing_zip.val('')
		@input_document_billing_country.val('')
	
	clearShippingAddressFields: ->
		@input_document_shipping_street1.val('')
		@input_document_shipping_street2.val('')
		@input_document_shipping_city.val('')
		@input_document_shipping_state.val('')
		@input_document_shipping_zip.val('')
		@input_document_shipping_country.val('')

	clearCompanyPhonesDropDown: ->
		@document_company_phone_dropdown_toggle.hide()
		@document_company_phone_dropdown_list.empty()
		
	clearCompanyFaxDropDown: ->
		@document_company_fax_dropdown_toggle.hide()
		@document_company_fax_dropdown_list.empty()
	
	clearBillingAddressDropDown: ->
		@document_billing_address_dropdown_toggle.hide()
		@document_billing_address_dropdown_list.empty()

	clearShippingAddressDropDown: ->
		@document_shipping_address_dropdown_toggle.hide()
		@document_shipping_address_dropdown_list.empty()

	clearCompanyContactDropDown: ->
		@document_contact_dropdown_toggle.hide()
		@document_contact_dropdown_list.empty()

	companyPhoneClicked: (evt)->
		self = @
		@input_document_company_phone.val($(evt.target).attr('data-attr'))
	
	companyFaxClicked: (evt)->
		self = @
		@input_document_company_fax.val($(evt.target).attr('data-attr'))
		
	clearContactFields: ->
		@input_document_contact_phone.val('')
		@input_document_contact_email.val('')
		@clearContactPhonesDropDown()
		@clearContactEmailDropDown()

	clearContactPhonesDropDown: ->
		@document_contact_phone_dropdown_toggle.hide()
		@document_contact_phone_dropdown_list.empty()

	clearContactEmailDropDown: ->
		@document_contact_email_dropdown_toggle.hide()
		@document_contact_email_dropdown_list.empty()

	contactPhoneClicked: (evt)->
		self = @
		@input_document_contact_phone.val($(evt.target).attr('data-attr'))

	contactEmailClicked: (evt)->
		self = @
		@input_document_contact_email.val($(evt.target).attr('data-attr'))
	
	contactNameClicked: (evt)->
		self = @
		@contact = _.find(self.contacts.models, (m) -> m.get("pub_key") == $(evt.target).attr('data-attr'))
		if @contact
			@model.set({contact_key: @contact.get("pub_key"), silent: true})
			@input_document_contact_key.val(@contact.get("pub_key"))
			@input_document_contact_name.val(@contact.get("name"))
			@handleContactChanged()

	billingAddressClicked: (evt)->
		self = @
		address = _.find(self.company.get("addresses"), (m) -> m.pub_key == $(evt.target).attr('data-attr'))
		if address
			@input_document_billing_street1.val(address.street1)
			@input_document_billing_street2.val(address.street2)
			@input_document_billing_city.val(address.city)
			@input_document_billing_state.val(address.state)
			@input_document_billing_zip.val(address.zip)
			@input_document_billing_country.val(address.country)

	shippingAddressClicked: (evt)->
		self = @
		address = _.find(self.company.get("addresses"), (m) -> m.pub_key == $(evt.target).attr('data-attr'))
		if address
			@input_document_shipping_street1.val(address.street1)
			@input_document_shipping_street2.val(address.street2)
			@input_document_shipping_city.val(address.city)
			@input_document_shipping_state.val(address.state)
			@input_document_shipping_zip.val(address.zip)
			@input_document_shipping_country.val(address.country)
			
	sameAsBillingClicked: ->
		@input_document_shipping_street1.val(@input_document_billing_street1.val())
		@input_document_shipping_street2.val(@input_document_billing_street2.val())
		@input_document_shipping_city.val(@input_document_billing_city.val())
		@input_document_shipping_state.val(@input_document_billing_state.val())
		@input_document_shipping_zip.val(@input_document_billing_zip.val())
		@input_document_shipping_country.val(@input_document_billing_country.val())

	getCompanyContacts: (company_key)->
		self = @
		_.filter(self.contacts.models, (m) -> m.get("company_key") == company_key)
		

	setMilestoneRelatedFields: ->
		# self = @
		# 		ct = _.find self.contact_types.models, (cm) -> cm.get("pub_key") == self.model.get("contact_type_key")
		# 		if ct and ct.get("name") == "Company"
		# 			@contact_title.hide()
		# 			@contact_company_name.hide()
		# 			@input_contact_name.attr('placeholder', 'Company Name')
		# 		else
		# 			@contact_title.show()
		# 			@contact_company_name.show()
		# 			@input_contact_name.attr('placeholder', 'First Last')
