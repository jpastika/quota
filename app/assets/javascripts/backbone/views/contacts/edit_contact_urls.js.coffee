class Quota.Views.EditContactUrls extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: '#contact_urls_container'
	
	events:
		"click #contact-urls-actions>.btn-primary": "addClicked"
		"click #contact-urls-actions>.btn-danger": "doneClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@contact = options.parent_model
		@parent_child_key = options.parent_child_key
		
		@_addUrlView = new Quota.Views.EditContactFormAddUrl({model: new Quota.Models.ContactUrl(), parent_model:@contact, parent_child_key: @contact.get("pub_key"), vent: @vent, parent_collection: @collection})
		
		@_urlsListView = new Quota.Views.EditContactUrlsList({model: new Quota.Models.ContactUrl(), parent_model:@contact, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@vent.on('contact_urls:add_new_url_successful', @addNewUrl_Success, @)
		@vent.on('contact_urls:remove_url', @removeContactUrl, @)
		
		
	render: ->
		@container_url_list = @$('.section-table tbody')
		@_urlsListView.setElement(@container_url_list).render()
		@container_add_url = @$('.section-form')
		@_addUrlView.setElement(@container_add_url).render()
		@
	
	addClicked: ->
		@vent.trigger('add_url:clicked')
		@_addUrlView.resetAddNewUrlForm()
		@hideAddBtn()
		@showDoneLink()
		@showAddForm()
		

	doneClicked: ->
		@vent.trigger('done_add_url:clicked')
		@_addUrlView.resetAddNewUrlForm()
		@hideDoneLink()
		@showAddBtn()
		@hideAddForm()
		
	removeContactUrl: (item)->
		@collection.remove(item)
		
	addNewUrl_Success: ()->
		@doneClicked()

	hideAddBtn: ->
		@$('#contact-urls-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#contact-urls-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#contact-urls-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#contact-urls-actions>.btn-danger').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)
