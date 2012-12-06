class Quota.Views.EditContactFormAddEmail extends Backbone.View

	template: HandlebarsTemplates['contacts/edit_contact_form_add_email'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click #contact-add-new-email-actions .btn-success": "clickAddNew"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_email:clicked', @showAddEmail, @)
		@vent.on('done_add_email:clicked', @hideAddEmail, @)
		
		@contact = options.parent_model
		@contact_emails = options.parent_collection
		
	render: ->
		$(@el).html(@template({contact:@contact}))
		@input_name = @$('.email_name input')
		@input_val = @$('.email_val input')
		@input_contact_key = @$('.contact_key input')
		
		@loading = @$('.section-loading')
		
		@
		
	show: ->
		$(@el).toggle(true)
		
	hide: ->
		$(@el).toggle(false)
		
	showAddEmail: ->
		@show()
		
	hideAddEmail: ->
		@hide()
	
	showLoading: ->
		@loading.toggle(true)

	hideLoading: ->
		@loading.toggle(false)
	
	clickAddNew: ->
		self = @
		contact_email = new Quota.Models.ContactEmail()
		contact_email.set("name", self.input_name.val())
		contact_email.set("val", self.input_val.val())
		contact_email.set("contact_key", self.contact.get("pub_key"))
		self.vent.trigger('contact_emails:add_new_email_successful', {model: contact_email})
		self.resetAddNewEmailForm()
		
	
	# removeContactEmail: (item)->
	# 		@_contactsView.setElement(@container_contacts).render()
		
	resetAddNewEmailForm: ->
		@input_name.val('')
		@input_val.val('')
		@input_contact_key.val('')