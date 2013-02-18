class Quota.Views.IndexOpportunities extends Backbone.View

	el: '#opportunities_container .section-table tbody'
	
	
	# events:
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@_opportunityViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('opportunity_link:clicked', @opportunityLinkClicked, @)
		
	render: ->
		$(@el).empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		$(@el).append(frag)
		console.log @el
		@
	
	addOne: (item)->
		view = new Quota.Views.IndexOpportunity({model: item, className:'opportunity', opportunity: @model, vent: @vent})
		@_opportunityViews.push(view)
		view
	
	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_opportunityViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
	
	opportunityLinkClicked: (evt) ->
		# console.log evt.view.model.get("name")
	# 		@setContactTypeRelatedFields()