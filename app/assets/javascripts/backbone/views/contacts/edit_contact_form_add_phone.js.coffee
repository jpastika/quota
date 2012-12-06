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
		self.vent.trigger('contact_phones:add_new_phone_successful', {model: contact_phone})
		self.resetAddNewPhoneForm()
		
	
	# removeContactPhone: (item)->
	# 		@_contactsView.setElement(@container_contacts).render()
		
	resetAddNewPhoneForm: ->
		@input_name.val('')
		@input_val.val('')
		@input_contact_key.val('')