class Quota.Views.EditContactFormAddPhone extends Backbone.View

	template: HandlebarsTemplates['contacts/edit_contact_form_add_phone'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click #contact-add-new-phone-actions .btn-success": "clickAddNew"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_phone:clicked', @showAddPhone, @)
		@vent.on('done_add_phone:clicked', @hideAddPhone, @)
		
		@contact = options.parent_model
		@contact_phones = options.parent_collection
		
	render: ->
		$(@el).html(@template({contact:@contact}))
		@input_name = @$('.phone_name input')
		@input_val = @$('.phone_val input')
		@input_contact_key = @$('.contact_key input')
		
		@loading = @$('.section-loading')
		
		@
		
	show: ->
		$(@el).toggle(true)
		
	hide: ->
		$(@el).toggle(false)
		
	showAddPhone: ->
		@show()
		
	hideAddPhone: ->
		@hide()
	
	showLoading: ->
		@loading.toggle(true)

	hideLoading: ->
		@loading.toggle(false)
	
	clickAddNew: ->
		self = @
		contact_phone = new Quota.Models.ContactPhone()
		contact_phone.set("name", self.input_name.val())
		contact_phone.set("val", self.input_val.val())
		contact_phone.set("contact_key", self.contact.get("pub_key"))
		# contact_phone.save(
		# 			{
		# 				name: @input_contact_name.val()
		# 				company_name: @$('#contact_company_name').val()
		# 				company_key: @input_contact_company_key.val()
		# 				contact_phone: @input_contact_phone.val()
		# 				contact_email: @input_contact_email.val()
		# 				# account_key: @opportunity.get("account_key")
		# 			},
		# 			{
		# 				error: ->
		# 					console.log "save error"
		# 				success: (model) -> 
		# 					self.resetAddNewContactForm()
		# 					opportunity_contact = new Quota.Models.OpportunityContact({opportunity_key: self.opportunity.get("pub_key"), contact_key: model.get("pub_key")})
		# 					opportunity_contact.save(
		# 						{
		# 							opportunity_key: opportunity_contact.get("opportunity_key")
		# 							contact_key: opportunity_contact.get("contact_key")
		# 						},
		# 						{
		# 							error: ->
		# 								console.log "save error"
		# 							success: (model) -> 
		# 								self.opportunity_contacts.add(model)
		# 								self.vent.trigger('company_contacts:add_new_contact_successful', {model: model})
		# 								self._contactsView.contacts.add(model.get("contact"))
		# 						}
		# 					)
		# 			}
		# 		)
		#
		self.vent.trigger('contact_phones:add_new_phone_successful', {model: contact_phone})
		self.resetAddNewPhoneForm()
		
	
	# removeContactPhone: (item)->
	# 		@_contactsView.setElement(@container_contacts).render()
		
	resetAddNewPhoneForm: ->
		@input_name.val('')
		@input_val.val('')
		@input_contact_key.val('')