class Quota.Views.ShowOpportunityContacts extends Backbone.View

	
	template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .actions-bar-left>.btn": "addContactClicked"
		"click .cancel-link": "doneAddContactClicked"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_contactViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('company_contacts:add_contact', @addCompanyContact, @)
		@vent.on('company_contacts:add_new_contact_successful', @addNewContact_Success, @)
		@opportunity = options.parent_model
		@_addContactView = new Quota.Views.ShowOpportunityFormAddContact({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @opportunity.get("pub_key"), vent: @vent})
		
		
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
		@_addContactView.resetAddNewContactForm()
		@hideAddBtn()
		@showDoneLink()
		
	doneAddContactClicked: ->
		@vent.trigger('done_add_contact:clicked')
		@_addContactView.resetAddNewContactForm()
		@hideDoneLink()
		@showAddBtn()
		
	hideAddBtn: ->
		@$('.actions-bar-left .btn').first().toggle(false)
		
	showAddBtn: ->
		@$('.actions-bar-left .btn').first().toggle(true)
		
	hideDoneLink: ->
		@$('.cancel-link').toggle(false)

	showDoneLink: ->
		@$('.cancel-link').toggle(true)
		
	addCompanyContact: (obj)->
		self = @
		contact = new Quota.Models.OpportunityContact()
		contact.save(
			{
				opportunity_key: @opportunity.get("pub_key")
				contact_key: obj.contact.get("pub_key")
				account_key: @opportunity.get("account_key")
			},
			{
				error: @handleError
				success: (model) -> 
					self.addCompanyContact_Success(model)
				# silent: true
			}
		)
		
	addNewContact_Success: (obj)->
		@addCompanyContact_Success(obj.model)
		
	addCompanyContact_Success: (model)->
		self = @
		self.collection.add(model)
		frag = document.createDocumentFragment()
		frag.appendChild(self.addOne(model).render().el)
		self.$('tbody').append(frag)
	
	handleError: (attribute, message) ->
		console.log message