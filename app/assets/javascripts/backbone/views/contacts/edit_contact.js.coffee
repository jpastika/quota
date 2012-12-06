class Quota.Views.EditContact extends Backbone.View
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		Backbone.Validation.bind(
			@
			valid: (view, attr) ->
				self.clearError(attr)
			invalid: (view, attr, error) ->
				self.clearError(attr)
				self.handleError(attr, error)
		)
		@el = options.el
		@vent = options.vent
		@companies = options.companies
		@contact_phones = @model.contact_phones
		@contact_emails = @model.contact_emails
		@contact_addresses = @model.contact_addresses
		@contact_urls = @model.contact_urls
		@model.on('change', @render, @)
		@vent.on('company_name:changed', @companyNameChanged, @)
		@vent.on('contact:rendered', @rendered, @)
		
		@_companyComboView = new Quota.Views.CompanyComboView({parent_model:@model, collection:@companies, source: "name", val: "pub_key", className: 'string input-xlarge', vent: @vent})
			
		@_phonesView = new Quota.Views.EditContactPhones({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@contact_phones, vent: @vent})
		@_emailsView = new Quota.Views.EditContactEmails({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@contact_emails, vent: @vent})
		@_urlsView = new Quota.Views.EditContactUrls({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@contact_urls, vent: @vent})
		@_addressesView = new Quota.Views.EditContactAddresses({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@contact_addresses, vent: @vent})
		
		
	render: ->
		self = @
		@contact_name = @$('.contact_name')
		@contact_company_name = $('.contact_company')
		@input_contact_company_name = $('#contact_company_name')
		@input_contact_company_key = $('#contact_company_key')
		company_name_field_name = @input_contact_company_name.attr('name')
		company_name_field_id = @input_contact_company_name.attr('id')
		
		@_companyComboView.setElement(@contact_company_name).render()
		
		@input_contact_company_name = $('.contact_company input')
		
		@input_contact_company_name.attr('name', company_name_field_name)
		@input_contact_company_name.attr('id', company_name_field_id)
		
		@container_phones = @$('#contact_phones_container')
		@container_emails = @$('#contact_emails_container')
		@container_urls = @$('#contact_urls_container')
		@container_addresses = @$('#contact_addresses_container')
		
		@_phonesView.setElement(@container_phones).render()
		@_emailsView.setElement(@container_emails).render()
		@_urlsView.setElement(@container_urls).render()
		@_addressesView.setElement(@container_addresses).render()
		@vent.trigger("contact:rendered")
		@
		
	setup: ->
		self = @
		@contact_name = @$('.contact_name')
		@contact_company_name = $('.contact_company')
		@input_contact_company_name = $('#contact_company_name')
		@input_contact_company_key = $('#contact_company_key')
		company_name_field_name = @input_contact_company_name.attr('name')
		company_name_field_id = @input_contact_company_name.attr('id')
		
		@_companyComboView.setElement(@contact_company_name).render()
		
		@input_contact_company_name = $('.contact_company input')
		
		@input_contact_company_name.attr('name', company_name_field_name)
		@input_contact_company_name.attr('id', company_name_field_id)
		
		@container_phones = @$('#contact_phones_container')
		@container_emails = @$('#contact_emails_container')
		@container_urls = @$('#contact_urls_container')
		@container_addresses = @$('#contact_addresses_container')
		
		@_phonesView.setElement(@container_phones).render()
		@_emailsView.setElement(@container_emails).render()
		@_urlsView.setElement(@container_urls).render()
		@_addressesView.setElement(@container_addresses).render()
		@vent.trigger("contact:rendered")
		
	
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
				
	# milestoneChanged: (evt) ->
	# 		self = @
	# 		milestone = evt.milestone
	# 		if milestone
	# 			@model.set("probability", milestone.get("probability"), {silent: true})
	# 			@input_opportunity_probability.attr('value', (milestone.get("probability") * 100))
	# 	
	companyNameChanged: (evt) ->
		self = @
		company = _.find(self.companies.models, (m) -> m.get("name") == evt.company_name)
		if company
			@model.set("company_key", company.get("pub_key"), {silent: true})
			@input_contact_company_key.val(company.get("pub_key"))
			# @save()
		else
			@model.unset("company_key", {silent: true})
			@input_contact_company_key.val('')
			# if evt.company_name != ''
			# 				company = new Quota.Models.Contact()
			# 				company.save(
			# 					{
			# 						name: evt.company_name
			# 						contact_type_key: _.first(self.contact_types.where({name: "Company"})).get("pub_key")
			# 					},{
			# 						error: (model, response) ->
			# 							self.handleError(model, response)
			# 						success: (model) ->
			# 							self.companies.add(model)
			# 							self._companySelectView.remove()
			# 							self.model.set("company_key", model.get("pub_key"), {silent: true})
			# 							self._companySelectView = new Quota.Views.CompanySelectView({parent_model:self.model, collection:self.companies, source: "name", val: "pub_key", className: 'string input-xlarge', vent: self.vent})
			# 							self.contact_company_name.html(self._companySelectView.render().el)
			# 							self.save()
			# 					}
			# 				)
			# 			else
			# 				@save()