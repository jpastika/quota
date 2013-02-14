class Quota.Views.EditDocument extends Backbone.View

	# template: HandlebarsTemplates['opportunities/edit_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .document_company_phone ul li": "companyPhoneClicked"
		"click .document_company_fax ul li": "companyFaxClicked"
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
		
		@_companyComboView = new Quota.Views.CompanyComboView({parent_model:@model, collection:@companies, source: "name", val: "pub_key", className: 'string span10', vent: @vent})
			
		@_contactComboView = new Quota.Views.ContactComboView({parent_model:@model, collection:@contacts, source: "name", val: "pub_key", company_key: @model.get("company_key"), className: 'string span10', vent: @vent})
		
		# @model.on('change', @render, @)
		@vent.on('company_name:changed', @companyNameChanged, @)
		@vent.on('contact_name:changed', @contactNameChanged, @)
		
	render: ->
		self = @
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		
		@document_name = @$('.document_name')
		@document_company_name = @$('.document_company_name div')
		@document_contact_name = @$('.document_contact_name div')
		@document_company_phone = @$('.document_company_phone')
		@document_company_phone_dropdown_toggle = @$('.document_company_phone .dropdown-toggle')
		@document_company_phone_dropdown_list = @$('.document_company_phone ul')
		@document_company_fax = @$('.document_company_fax')
		@document_company_fax_dropdown_toggle = @$('.document_company_fax .dropdown-toggle')
		@document_company_fax_dropdown_list = @$('.document_company_fax ul')
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
		@input_document_billing_city = @$('.document_billing_city input')
		@input_document_billing_state = @$('.document_billing_state input')
		@input_document_billing_zip = @$('.document_billing_zip input')
		@input_document_billing_country = @$('.document_billing_country input')
		@input_document_shipping_street1 = @$('.document_shipping_street1 input')
		@input_document_shipping_street2 = @$('.document_shipping_street2 input')
		@input_document_shipping_city = @$('.document_shipping_city input')
		@input_document_shipping_state = @$('.document_shipping_state input')
		@input_document_shipping_zip = @$('.document_shipping_zip input')
		@input_document_shipping_country = @$('.document_shipping_country input')
		@input_document_notes_customer = @$('.document_notes_customer textarea')
		@input_document_notes_internal = @$('.document_notes_internal textarea')
		@input_document_company_key = @$('#document_company_key')
		@input_document_contact_key = @$('#document_contact_key')
		
		company_name_field_name = @input_document_company_name.attr('name')
		company_name_field_id = @input_document_company_name.attr('id')
		
		@_companyComboView.setElement(@document_company_name).render()
		# @opportunity_company_name.html(@_companySelectView.render().el)
		
		@input_document_company_name = @$('.document_company_name input')
		
		@input_document_company_name.attr('name', company_name_field_name)
		@input_document_company_name.attr('id', company_name_field_id)
		
		
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
		@document_company_name = @$('.document_company_name div')
		@document_contact_name = @$('.document_contact_name div')
		@document_company_phone = @$('.document_company_phone')
		@document_company_phone_dropdown_toggle = @$('.document_company_phone .dropdown-toggle')
		@document_company_phone_dropdown_list = @$('.document_company_phone ul')
		@document_company_fax = @$('.document_company_fax')
		@document_company_fax_dropdown_toggle = @$('.document_company_fax .dropdown-toggle')
		@document_company_fax_dropdown_list = @$('.document_company_fax ul')
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
		@input_document_billing_city = @$('.document_billing_city input')
		@input_document_billing_state = @$('.document_billing_state input')
		@input_document_billing_zip = @$('.document_billing_zip input')
		@input_document_billing_country = @$('.document_billing_country input')
		@input_document_shipping_street1 = @$('.document_shipping_street1 input')
		@input_document_shipping_street2 = @$('.document_shipping_street2 input')
		@input_document_shipping_city = @$('.document_shipping_city input')
		@input_document_shipping_state = @$('.document_shipping_state input')
		@input_document_shipping_zip = @$('.document_shipping_zip input')
		@input_document_shipping_country = @$('.document_shipping_country input')
		@input_document_notes_customer = @$('.document_notes_customer textarea')
		@input_document_notes_internal = @$('.document_notes_internal textarea')
		@input_document_company_key = @$('#document_company_key')
		@input_document_contact_key = @$('#document_contact_key')
		
		company_name_field_name = @input_document_company_name.attr('name')
		company_name_field_id = @input_document_company_name.attr('id')
		
		@_companyComboView.setElement(@document_company_name).render()
		# @opportunity_company_name.html(@_companySelectView.render().el)
		
		@input_document_company_name = @$('.document_company_name input')
		
		@input_document_company_name.attr('name', company_name_field_name)
		@input_document_company_name.attr('id', company_name_field_id)
		
		
		contact_name_field_name = @input_document_contact_name.attr('name')
		contact_name_field_id = @input_document_contact_name.attr('id')
		
		@_contactComboView.setElement(@document_contact_name).render()
		# @opportunity_company_name.html(@_companySelectView.render().el)
		
		@input_document_contact_name = @$('.document_contact_name input')
		
		@input_document_contact_name.attr('name', contact_name_field_name)
		@input_document_contact_name.attr('id', contact_name_field_id)
		@vent.trigger("document:rendered")
		
	
	rendered: ->
		# self = @
		# 		$(".opportunity_estimated_close .datepicker").on(
		# 			"blur"
		# 			() -> self.vent.trigger("estimated_close_date:blurred")
		# 		)
		# $('input[placeholder]').placeholder()
		# 		$('textarea[placeholder]').placeholder()
		
		
	save: ->
		# self = @
		# 		modelid = @model.id
		# 		@model.set("contact_type_key", @_contactTypesView.getSelected().model.get("pub_key"), {silent: true})
		# 		if @model.isValid(true)
		# 			@model.save(
		# 				{
		# 					name: @model.get("name")
		# 					title: @model.get("title")
		# 					contact_type_key: @model.get("contact_type_key")
		# 					company_key: @model.get("company_key")
		# 				},
		# 				{
		# 					error: @handleError
		# 					success: (model) -> 
		# 						if modelid != model.id
		# 							enablePushState = true  
		# 							pushState = !!(enablePushState and window.history and window.history.pushState)
		# 							if pushState
		# 								Backbone.history.navigate("contacts/" + model.get("pub_key") + "/edit", {trigger: false, replace: true})
		# 								_.each(self._contactPhonesView._phoneViews, (v) -> if v.shouldSave() then v.save())
		# 							else
		# 								_.each(self._contactPhonesView._phoneViews, (v) -> if v.shouldSave() then v.save())
		# 								window.location.replace(model.get("pub_key") + "/edit")
		# 					silent: true
		# 				}
		# 			)
	
	handleSaveErrors: (model, response) ->
		# if response.status == 422
		# 			errors = $.parseJSON(response.responseText).errors
		# 			for atttribute, messages of errors
		# 				self.handleError(attribute, message)
	
	handleError: (attribute, message) ->
		# @$el.find(".control-group.#{attribute}").addClass('error').find('.controls').append("<span class=\"help-inline\">#{message}</span>")
	
	clearError: (attribute) ->
		# @$el.find(".control-group.#{attribute}").removeClass('error').find('.help-inline').remove()
				
	companyNameChanged: (evt) ->
		self = @
		@company = _.find(self.companies.models, (m) -> m.get("name") == evt.company_name)
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
			# @save()
		else
			@contact = null
			@model.set({contact_key: '', silent: true})
			@input_document_contact_key.val('')
			
	handleCompanyChanged: ->
		@clearCompanyPhones()
		if @company
			@setupCompanyPhones()
			@setupCompanyContacts()
			
	setupCompanyPhones: ->
		company_phones = @company.get("phones")
		phones = _.filter(company_phones, (m) -> m.name.toLowerCase().indexOf("fax") == -1)
		faxes = _.filter(company_phones, (m) -> m.name.toLowerCase().indexOf("fax") != -1)
		
		if phones.length
			phone = phones[0]
			@input_document_company_phone.val(phone.val)
			
			if phones.length > 1
				@setupCompanyPhonesDropDown(phones)
		if faxes.length
			fax = faxes[0]
			@input_document_company_fax.val(fax.val)
			
			if faxes.length > 1
				@setupCompanyFaxesDropDown(faxes)
			
	setupCompanyPhonesDropDown: (phones)->
		self = @
		@document_company_phone_dropdown_toggle.show()
		_.each(phones, (m) -> self.document_company_phone_dropdown_list.append("<li data-attr=#{m.val}>#{m.val}</li>"))
		
	setupCompanyFaxesDropDown: (faxes)->
		self = @
		@document_company_fax_dropdown_toggle.show()
		_.each(faxes, (m) -> self.document_company_fax_dropdown_list.append("<li data-attr=#{m.val}>#{m.val}</li>"))

	clearCompanyPhones: ->
		@input_document_company_phone.val('')
		@input_document_company_fax.val('')
		@clearCompanyPhonesDropDown()
		@clearCompanyFaxDropDown()
		
	clearCompanyPhonesDropDown: ->
		@document_company_phone_dropdown_toggle.hide()
		@document_company_phone_dropdown_list.empty()
		
	clearCompanyFaxDropDown: ->
		@document_company_fax_dropdown_toggle.hide()
		@document_company_fax_dropdown_list.empty()
		
	companyPhoneClicked: (evt)->
		@input_document_company_phone.val($(evt.target).attr('data-attr'))
	
	companyFaxClicked: (evt)->
		@input_document_company_fax.val($(evt.target).attr('data-attr'))

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
