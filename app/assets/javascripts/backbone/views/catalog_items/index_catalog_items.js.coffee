class Quota.Views.IndexCatalogItems extends Backbone.View

	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	# events:
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@_catalogItemViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		
	render: ->
		$(@el).empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		$(@el).append(frag)
		@
	
	addOne: (item)->
		view = new Quota.Views.IndexCatalogItem({model: item, tagName:'li', className:'catalog_item', catalog_item: @model, vent: @vent})
		@_catalogItemViews.push(view)
		view
	
	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_catalogItemViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
	
	catalogItemLinkClicked: (evt) ->
		# console.log evt.view.model.get("name")
	# 		@setContactTypeRelatedFields()