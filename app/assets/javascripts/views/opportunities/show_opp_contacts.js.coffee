class Quota.Views.ShowOpportunityContacts extends Backbone.View

	
	template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .btn": "addContactClicked"
		"click .cancel-link": "doneAddContactClicked"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_contactViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@opportunity = options.parent_model
		@_addContactView = new Quota.Views.ShowOpportunityFormAddContact({parent_model:@opportunity, parent_child_key: @opportunity.get("pub_key"), vent: @vent})
		
		
	render: ->
		$(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$('tbody').append(frag)
		
		@hideDoneLink()
		
		@container_add_contact = @$('.section-form')
		@_addContactView.setElement(@container_add_contact).render().hide()
		@_addContactView.companies.fetch()
		
		@

	addOne: (item)->
		view = new Quota.Views.ShowOpportunityContact({model: item, tagName:'tr', opportunity: @model, vent: @vent})
		@_contactViews.push(view)
		view

	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_contactViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
		# console.log "got here"
	
	addContactClicked: ->
		@vent.trigger('add_contact:clicked')
		@hideAddBtn()
		@showDoneLink()
		
	doneAddContactClicked: ->
		@vent.trigger('done_add_contact:clicked')
		@hideDoneLink()
		@showAddBtn()
		
	hideAddBtn: ->
		@$('.btn').toggle(false)
		
	showAddBtn: ->
		@$('.btn').toggle(true)
		
	hideDoneLink: ->
		@$('.cancel-link').toggle(false)

	showDoneLink: ->
		@$('.cancel-link').toggle(true)