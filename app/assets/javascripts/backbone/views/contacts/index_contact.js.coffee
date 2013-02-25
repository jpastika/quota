class Quota.Views.IndexContact extends Backbone.View
	
	template: HandlebarsTemplates['contacts/index_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	el: '#contact'

	events:
		"click .contact_btn_edit": "handleEdit"
		"click .contact_btn_done": "handleDone"
		"click .contact_edit_is_company input": "handleIsCompanyClick"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		
		@phones = new Quota.Collections.ContactPhones(@model.get("phones"))
		@emails = new Quota.Collections.ContactEmails(@model.get("emails"))
		@urls = new Quota.Collections.ContactUrls(@model.get("urls"))
		@addresses = new Quota.Collections.ContactAddresses(@model.get("addresses"))
		
		@_phonesView = new Quota.Views.IndexContactPhones({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@phones, vent: @vent})
		@_emailsView = new Quota.Views.IndexContactEmails({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@emails, vent: @vent})
		@_urlsView = new Quota.Views.IndexContactUrls({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@urls, vent: @vent})
		@_addressesView = new Quota.Views.IndexContactAddresses({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@addresses, vent: @vent})
		
	render: ->
		$(@el).empty()
		$(@el).html(@template({contact:@model.toJSON()}))
		
		@contact_show = @$('.contact_show')
		@contact_edit = @$('.contact_edit')
		
		@contact_btn_edit = @$('.contact_btn_edit')
		@contact_btn_done = @$('.contact_btn_done')
		
		@container_phones = @$('.contact_phones')
		@container_emails = @$('.contact_emails')
		@container_urls = @$('.contact_urls')
		@container_addresses = @$('.contact_addresses')
		
		@container_icon = @$('.contact_icon')
		@container_name = @$('.contact_edit_name')
		@container_title = @$('.contact_edit_title')
		@container_company = @$('.contact_edit_company')
		@container_is_company = @$('.contact_edit_is_company')
		
		@icon = @$('.contact_icon i')
		@input_name = @$('.contact_edit_name input')
		@input_title = @$('.contact_edit_title input')
		@input_company = @$('.contact_edit_company input')
		@input_is_company = @$('.contact_edit_is_company input')
		
		@_phonesView.setElement(@container_phones).render()
		@_emailsView.setElement(@container_emails).render()
		@_urlsView.setElement(@container_urls).render()
		@_addressesView.setElement(@container_addresses).render()
		
		@
		
	handleEdit: ->
		@vent.trigger('contact:edit')
		@toggleEdit()
		
	handleDone: ->
		@vent.trigger('contact:done')
		@toggleShow()
	
	toggleEdit: ->
		@contact_show.hide()
		@contact_edit.show()
		@contact_btn_edit.hide()
		@contact_btn_done.show()
		
	toggleShow: ->
		@contact_edit.hide()
		@contact_show.show()
		@contact_btn_done.hide()
		@contact_btn_edit.show()
		
	handleIsCompanyClick: ->
		if @input_is_company.is(':checked')
			@container_title.hide()
			@container_company.hide()
			@icon.removeClass('icon-user').addClass('icon-building')
		else
			@container_title.show()
			@container_company.show()
			@icon.removeClass('icon-building').addClass('icon-user')