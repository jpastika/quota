class Quota.Views.ShowDocumentItemsList extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-document").html()) #JST['quotes/index']
	
	el: '#items_container .section-table-rows ul'
	
	events:
		"update-sort": "updateOrder"

	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_itemViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@document_model = options.parent_model
		
		@vent.on('document_items:set_focus', @setDocumentItemFocus, @)
		
	render: ->
		# $(@el).html(@document({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		
		@makeSortable()
		@

	addOne: (item)->
		view = new Quota.Views.ShowDocumentItem({model: item, tagName:'li', document_item: @model, parent_model: @document_model, vent: @vent})
		@_itemViews.push(view)
		view
		
	makeSortable: ->
		@$el.sortable({
			axis: "y"
			, items: "> li"
			, handle: ".icon-sort"
			, stop: @sortStop
			, placeholder: "document_item_drag_highlight"
			, opacity: 0.75
		})

	setDocumentItemFocus: (obj) ->
		for view in @_itemViews 
			do (view) ->
				if obj.view isnt view then view.doShowMode()

	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_itemViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
		# console.log "got here"

	sortStop: (event, ui) ->
		ui.item.trigger('drop', ui.item.index());

	hideRemove: () ->
		@hideRemove = true
		@$el.find('.document_item_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		@$el.find('.document_item_remove').css('visibility', '')
		
	updateOrder: (event, model, position) ->           
		@collection.remove(model)

		@collection.each(
			(model, index) ->
			   	ordinal = index
			   	if (index >= position)
			       	ordinal += 1
			   	model.set('sort_order', ordinal)
		)           

		model.set('sort_order', position)
		@collection.add(model, {at: position})

		@collection.sync("create", @collection, {url: '/api/document_items/reorder'})
		
	setSortOrder: ->           
		@collection.each(
			(model, index) ->
				ordinal = index
				model.set('sort_order', ordinal)
		)           

		@collection.sync("create", @collection, {url: '/api/document_items/reorder'})

	addNewDocumentItem_Success: (model)->
		@addDocumentItem_Success(model)

	addNewDocumentItem_Success: (model)->
		self = @
		
		self.document_model.get("document_items").add(model)
		frag = document.createDocumentFragment()
		frag.appendChild(self.addOne(model).render().el)
		self.$el.append(frag)
		self.vent.trigger('document_items:set_totals')

	handleError: (attribute, message) ->
		# console.log message