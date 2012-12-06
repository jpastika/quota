class Quota.Views.EditContactFormAddAddress extends Backbone.View

	template: HandlebarsTemplates['contacts/edit_contact_form_add_address'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click #contact-add-new-address-actions .btn-success": "clickAddNew"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_address:clicked', @showAddAddress, @)
		@vent.on('done_add_address:clicked', @hideAddAddress, @)
		
		@contact = options.parent_model
		@contact_addresses = options.parent_collection
		
	render: ->
		$(@el).html(@template({contact:@contact}))
		@input_name = @$('.address_name input')
		@input_street1 = @$('.address_street1 input')
		@input_city = @$('.address_city input')
		@input_state = @$('.address_state input')
		@input_zip = @$('.address_zip input')
		@input_country = @$('.address_country input')
		@input_contact_key = @$('.contact_key input')
		
		@loading = @$('.section-loading')
		
		@
		
	show: ->
		$(@el).toggle(true)
		
	hide: ->
		$(@el).toggle(false)
		
	showAddAddress: ->
		@show()
		
	hideAddAddress: ->
		@hide()
	
	showLoading: ->
		@loading.toggle(true)

	hideLoading: ->
		@loading.toggle(false)
	
	clickAddNew: ->
		self = @
		contact_address = new Quota.Models.ContactAddress()
		contact_address.set("name", self.input_name.val())
		contact_address.set("street1", self.input_street1.val())
		contact_address.set("city", self.input_city.val())
		contact_address.set("state", self.input_state.val())
		contact_address.set("zip", self.input_zip.val())
		contact_address.set("country", self.input_country.val())
		contact_address.set("contact_key", self.contact.get("pub_key"))
		self.vent.trigger('contact_addresses:add_new_address_successful', {model: contact_address})
		self.resetAddNewAddressForm()
		
	
	# removeContactAddress: (item)->
	# 		@_contactsView.setElement(@container_contacts).render()
		
	resetAddNewAddressForm: ->
		@input_name.val('')
		@input_street1.val('')
		@input_city.val('')
		@input_state.val('')
		@input_zip.val('')
		@input_country.val('')
		@input_contact_key.val('')