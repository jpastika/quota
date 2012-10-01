class Quota.Views.ShowOpportunityContactsList extends Backbone.View

	
	template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	# events:
	# 		"click .contact_remove": "destroy"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_contactViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@opportunity = options.parent_model
		
		@vent.on('company_contacts:add_contact', @addCompanyContact, @)
		@vent.on('company_contacts:add_new_contact_successful', @addNewContact_Success, @)
		
		# @companies = options.companies
		
	render: ->
		$(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$('tbody').append(frag)
		
		@

	addOne: (item)->
		# if item.get("contact").company_key
		# 			view = new Quota.Views.ShowOpportunityContact({model: item, tagName:'tr', opportunity: @model, company: _.first(@companies.where(pub_key: item.get("contact").company_key)), vent: @vent})
		# 		else
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

	# destroy: (evt) ->
	# 		$(@el).toggle()
	# 		# @model.trigger('removing', {view: @})
	# 		@model.remove()

	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.contact_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		$(@el).find('.contact_remove').css('visibility', '')
		
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