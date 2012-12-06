class Quota.Views.EditContactFormAddUrl extends Backbone.View

	template: HandlebarsTemplates['contacts/edit_contact_form_add_url'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click #contact-add-new-url-actions .btn-success": "clickAddNew"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_url:clicked', @showAddUrl, @)
		@vent.on('done_add_url:clicked', @hideAddUrl, @)
		
		@contact = options.parent_model
		@contact_urls = options.parent_collection
		
	render: ->
		$(@el).html(@template({contact:@contact}))
		@input_name = @$('.url_name input')
		@input_val = @$('.url_val input')
		@input_contact_key = @$('.contact_key input')
		
		@loading = @$('.section-loading')
		
		@
		
	show: ->
		$(@el).toggle(true)
		
	hide: ->
		$(@el).toggle(false)
		
	showAddUrl: ->
		@show()
		
	hideAddUrl: ->
		@hide()
	
	showLoading: ->
		@loading.toggle(true)

	hideLoading: ->
		@loading.toggle(false)
	
	clickAddNew: ->
		self = @
		contact_url = new Quota.Models.ContactUrl()
		contact_url.set("name", self.input_name.val())
		contact_url.set("val", self.input_val.val())
		contact_url.set("contact_key", self.contact.get("pub_key"))
		self.vent.trigger('contact_urls:add_new_url_successful', {model: contact_url})
		self.resetAddNewUrlForm()
		
	
	# removeContactUrl: (item)->
	# 		@_contactsView.setElement(@container_contacts).render()
		
	resetAddNewUrlForm: ->
		@input_name.val('')
		@input_val.val('')
		@input_contact_key.val('')