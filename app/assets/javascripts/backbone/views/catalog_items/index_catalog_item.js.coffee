class Quota.Views.IndexCatalogItem extends Backbone.View

	template: HandlebarsTemplates['catalog_items/index_catalog_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .catalog-item" : "handleClick"
		# "click .icon-remove": "destroy"
		# 		"click .catalog_item_link": "catalogItemLinkClicked"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@catalog_item = options.catalog_item
		@vent = options.vent
		@_catalogItemChildViews = []
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({catalog_item:@model.toJSON()}))
		@unit_price = @$('.catalog_item_unit_price')
		@unit_price.html(accounting.formatMoney(@model.get("list_price"), "$ "))
		@children_container = @$('.catalog-item-children')
		@children_list = @$('.catalog-item-children ul')
		@children_toggle = @$('.icon-sort-down')
		
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @model.get("child_items")
		@children_list.append(frag)
		@
	
	addOne: (item)->
		view = new Quota.Views.IndexCatalogItemChildItem({model: new Quota.Models.CatalogItem(item), tagName:'li', vent: @vent})
		@_catalogItemChildViews.push(view)
		view
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	toggle: () ->
		$(@el).toggle()
		
	handleClick: (evt) ->
		self = @
		
		if $(evt.target).hasClass("icon-remove")
			@destroy()
			return true
		if $(evt.target).hasClass("icon-sort-down")
			@expandChildren()
			return true
		if $(evt.target).hasClass("icon-sort-up")
			@collapseChildren()
			return true
			
		@catalogItemLinkClicked()
		
	catalogItemLinkClicked: ->
		# console.log "clicked"
		window.location.href="/catalog/#{@model.get("pub_key")}"
		# @vent.trigger("catalog_item_link:clicked", {view: @})
		
	collapseChildren: ->
		@children_container.hide()
		@children_toggle.removeClass('icon-sort-up').addClass('icon-sort-down')
		
	expandChildren: ->
		@children_container.show()
		@children_toggle.removeClass('icon-sort-down').addClass('icon-sort-up')
		