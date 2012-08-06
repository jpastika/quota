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
		@vent.on('add_contact', @addCompanyContact, @)
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
		@$('.section-heading .btn').toggle(false)
		
	showAddBtn: ->
		@$('.section-heading .btn').toggle(true)
		
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
					self.collection.add(model.get("contact"))
					#THIS IS ANOT A GOOD PLAN
					#TODO: FIX THIS
					self.render()
					# frag = document.createDocumentFragment()
					# 					view = new Quota.Views.ShowOpportunityContact({model: model.get("contact"), tagName:'tr', opportunity: self.model, vent: self.vent})
					# 					self._contactViews.push(view)
					# 					frag.appendChild(view.render().el)
					# 					self.$('tbody').append(frag)
					# self.model.url = 'phones/'+model.get("pub_key")
					# 					self.hideRemove = false
					# 					self.model.trigger('change')
					# 					self.vent.trigger("contact_phones:check_empty")
					# console.log "contact added to opportunity"
				# silent: true
			}
		)
	
	handleError: (attribute, message) ->
		console.log message