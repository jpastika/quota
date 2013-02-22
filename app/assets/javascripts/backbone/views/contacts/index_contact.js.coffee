class Quota.Views.IndexContact extends Backbone.View
	
	template: HandlebarsTemplates['contacts/index_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	el: '#contact'

	events:
		"click .contact_show": "toggleEdit"
		"blur .contact_edit input": "toggleShow"
	# 		
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
		
		@container_phones = @$('.contact_phones')
		@container_emails = @$('.contact_emails')
		@container_urls = @$('.contact_urls')
		@container_addresses = @$('.contact_addresses')
		
		@_phonesView.setElement(@container_phones).render()
		@_emailsView.setElement(@container_emails).render()
		@_urlsView.setElement(@container_urls).render()
		@_addressesView.setElement(@container_addresses).render()
		
		@
		
	toggleEdit: ->
		@contact_show.hide()
		@contact_edit.show()
		
	toggleShow: ->
		@contact_edit.hide()
		@contact_show.show()