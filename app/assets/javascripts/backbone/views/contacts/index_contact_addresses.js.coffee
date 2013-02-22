class Quota.Views.IndexContactAddresses extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# el: '#contact_addresses_container'
	el: '.contact_addresses'
	
	events:
		"click #contact-addresses-actions>.btn-primary": "addClicked"
		"click #contact-addresses-actions>.btn-danger": "doneClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@contact = options.parent_model
		@parent_child_key = options.parent_child_key
		
		@_addAddressView = new Quota.Views.EditContactFormAddAddress({model: new Quota.Models.ContactAddress(), parent_model:@contact, parent_child_key: @contact.get("pub_key"), vent: @vent, parent_collection: @collection})
		
		@_addressesListView = new Quota.Views.IndexContactAddressesList({model: new Quota.Models.ContactAddress(), parent_model:@contact, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@vent.on('contact_addresses:add_new_address_successful', @addNewAddress_Success, @)
		@vent.on('contact_addresses:remove_address', @removeContactAddress, @)
		
		
	render: ->
		@container_address_list = @$('.contact_addresses_list')
		@_addressesListView.setElement(@container_address_list).render()
		@container_add_address = @$('.section-form')
		@_addAddressView.setElement(@container_add_address).render()
		@
	
	addClicked: ->
		@vent.trigger('add_address:clicked')
		@_addAddressView.resetAddNewAddressForm()
		@hideAddBtn()
		@showDoneLink()
		@showAddForm()
		

	doneClicked: ->
		@vent.trigger('done_add_address:clicked')
		@_addAddressView.resetAddNewAddressForm()
		@hideDoneLink()
		@showAddBtn()
		@hideAddForm()
		
	removeContactAddress: (item)->
		@collection.remove(item)
		
	addNewAddress_Success: ()->
		@doneClicked()

	hideAddBtn: ->
		@$('#contact-addresses-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#contact-addresses-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#contact-addresses-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#contact-addresses-actions>.btn-danger').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)
