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
		
		@_phonesListView = new Quota.Views.EditContactPhonesList({model: new Quota.Models.ContactPhone(), parent_model:@contact, parent_child_key: @parent_child_key, vent: @vent, collection: @contact.phones})
		
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






# class Quota.Views.EditContactPhones extends Backbone.View
# 
# 	tagName: 'ul'
# 	className: 'unstyled form-vertical'
# 	
# 	initialize: (options)->
# 		_.bindAll(@)
# 		@vent = options.vent
# 		@_phoneViews = []
# 		@collection.on('reset', @collectionReset, @)
# 		@collection.on('destroy:error', @removeFailed, @)
# 		@collection.on('destroy:success', @removeSuccess, @)
# 		@vent.on('contact_phones:check_empty', @checkEmpty, @)
# 		
# 	render: ->
# 		$(@el).empty()
# 		frag = document.createDocumentFragment()
# 		frag.appendChild(@addOne(item).render().el) for item in @collection.models
# 		frag.appendChild(@addEmpty(new Quota.Models.ContactPhone({name:'', val:''})).render().el)
# 		$(@el).append(frag)
# 		@$('input[placeholder]').placeholder()
# 		@$('textarea[placeholder]').placeholder()
# 		@
# 	
# 	addOne: (item)->
# 		view = new Quota.Views.EditContactPhone({model: item, tagName:'li', className:'contact_method contact_phone', contact: @model, vent: @vent})
# 		@_phoneViews.push(view)
# 		view
# 		
# 	addEmpty: (item)->
# 		@collection.add(item)
# 		view = new Quota.Views.EditContactPhone({model: item, tagName:'li', className:'contact_method contact_phone', contact: @model, vent: @vent, hideRemove: true})
# 		@_phoneViews.push(view)
# 		view
# 		
# 	checkEmpty: ->
# 		if !_.find(@collection.models, (m) -> m.isNew())
# 			$(@el).append(@addEmpty(new Quota.Models.ContactPhone({name:'', val:''})).render().el)
# 	
# 	collectionReset: ->
# 		@render()
# 		
# 	removeFailed: (evt) ->
# 		view = _.find(@_phoneViews, (view) -> view.model == evt.model)
# 		view.toggle()
# 		
# 	removeSuccess: (evt) ->
# 		# console.log "got here"