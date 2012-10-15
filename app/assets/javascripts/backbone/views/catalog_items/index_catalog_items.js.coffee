class Quota.Views.IndexCatalogItems extends Backbone.View

	el: '#catalog_items_container .section-table tbody'
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@_catalogItemViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		@vent.on('search:clicked', @searchClicked, @)
		
	render: ->
		@$el.empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		@

	addOne: (item)->
		view = new Quota.Views.IndexCatalogItem({model: item, tagName:'tr', catalog_item: @model, vent: @vent})
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
	
	searchClicked: (evt) ->
		# filterParams = {name:['Item 9','Item 3','Item 11'], color:black}
		# filterParams = {name:['Item 9','Item 3','Item 11']}
		filterParams = {name:['1','3','11']}

		@collection.filterData(filterParams);
	
	
		
	