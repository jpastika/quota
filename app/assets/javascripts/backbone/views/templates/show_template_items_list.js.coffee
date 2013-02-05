class Quota.Views.ShowTemplateItemsList extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
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
		@template_model = options.parent_model
		
		@vent.on('template_items:set_focus', @setTemplateItemFocus, @)
		
	render: ->
		# $(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		
		@makeSortable()
		@

	addOne: (item)->
		view = new Quota.Views.ShowTemplateItem({model: item, tagName:'li', template_item: @model, parent_model: @template_model, vent: @vent})
		@_itemViews.push(view)
		view
		
	makeSortable: ->
		@$el.sortable({
			axis: "y"
			, items: "> li"
			, handle: ".icon-sort"
			, stop: @sortStop
			, placeholder: "template_item_drag_highlight"
			, opacity: 0.75
		})

	setTemplateItemFocus: (obj) ->
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
		@$el.find('.template_item_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		@$el.find('.template_item_remove').css('visibility', '')
		
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

		@collection.sync("create", @collection, {url: '/api/template_items/reorder'})
		
	setSortOrder: ->           
		@collection.each(
			(model, index) ->
				ordinal = index
				model.set('sort_order', ordinal)
		)           

		@collection.sync("create", @collection, {url: '/api/template_items/reorder'})

	addNewTemplateItem_Success: (model)->
		@addTemplateItem_Success(model)

	addNewTemplateItem_Success: (model)->
		self = @
		
		self.template_model.get("template_items").add(model)
		frag = document.createDocumentFragment()
		frag.appendChild(self.addOne(model).render().el)
		self.$el.append(frag)
		self.vent.trigger('template_items:set_totals')

	handleError: (attribute, message) ->
		# console.log message