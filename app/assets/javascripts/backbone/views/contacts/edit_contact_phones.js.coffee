class Quota.Views.EditContactPhones extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: '#contact_phones_container'
	
	events:
		"click #contact-phones-actions>.btn-primary": "addClicked"
		"click #contact-phones-actions>.btn-danger": "doneClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@contact = options.parent_model
		@parent_child_key = options.parent_child_key
		
		@_addPhoneView = new Quota.Views.EditContactFormAddPhone({model: new Quota.Models.ContactPhone(), parent_model:@contact, parent_child_key: @contact.get("pub_key"), vent: @vent, parent_collection: @collection})
		
		@_phonesListView = new Quota.Views.EditContactPhonesList({model: new Quota.Models.ContactPhone(), parent_model:@contact, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@vent.on('contact_phones:add_new_phone_successful', @addNewPhone_Success, @)
		@vent.on('contact_phones:remove_phone', @removeContactPhone, @)
		
		
	render: ->
		@container_phone_list = @$('.section-table tbody')
		@_phonesListView.setElement(@container_phone_list).render()
		@container_add_phone = @$('.section-form')
		@_addPhoneView.setElement(@container_add_phone).render()
		@
	
	addClicked: ->
		@vent.trigger('add_phone:clicked')
		@_addPhoneView.resetAddNewPhoneForm()
		@hideAddBtn()
		@showDoneLink()
		@showAddForm()
		

	doneClicked: ->
		@vent.trigger('done_add_phone:clicked')
		@_addPhoneView.resetAddNewPhoneForm()
		@hideDoneLink()
		@showAddBtn()
		@hideAddForm()
		
	removeContactPhone: (item)->
		@collection.remove(item)
		
	addNewPhone_Success: ()->
		@doneClicked()

	hideAddBtn: ->
		@$('#contact-phones-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#contact-phones-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#contact-phones-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#contact-phones-actions>.btn-danger').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)
