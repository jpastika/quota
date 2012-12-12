class Quota.Views.IndexTemplates extends Backbone.View

	el: '#templates_container .section-table tbody'
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@_templateViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('catalog_item_link:clicked', @templateLinkClicked, @)
		@vent.on('search:clicked', @searchClicked, @)
		
	render: ->
		@$el.empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		@

	addOne: (item)->
		view = new Quota.Views.IndexTemplate({model: item, tagName:'tr', template_model: @model, vent: @vent})
		@_templateViews.push(view)
		view
	
	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_templateViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
	
	catalogItemLinkClicked: (evt) ->
		# console.log evt.view.model.get("name")
	# 		@setContactTypeRelatedFields()
	
	searchClicked: (evt) ->
		filterParams = {name:[evt.name_filter]}
		# filterParams = {name:['em 12','Item 3','2'], list_price:[20]}
		# filterParams = {list_price:[20], name:['em 12','Item 3','2']}

		@collection.filterData(filterParams, 'and');
		# @collection.filterData(filterParams, 'or');
	
	
		
