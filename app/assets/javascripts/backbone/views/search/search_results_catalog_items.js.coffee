class Quota.Views.SearchResultsCatalogItems extends Backbone.View
	
	template: HandlebarsTemplates['search/search_results_catalog_items'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@catalog_items_by_name = options.catalog_items_by_name
		@catalog_items_by_part_number = options.catalog_items_by_part_number
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
		@catalog_items_by_name_view = new Quota.Views.SearchResultsCatalogItemsSubList({collection: @catalog_items_by_name, title: "w/ matching Name", vent: @vent})
		@catalog_items_by_part_number_view = new Quota.Views.SearchResultsCatalogItemsSubList({collection: @catalog_items_by_part_number, title: "w/ matching Part Number", vent: @vent})
		
	render: ->
		$(@el).html(@template())
		# @
		
		@items = @$('.search_results_table_rows')
		frag = document.createDocumentFragment()
		
		if @catalog_items_by_name.length
			frag.appendChild(@catalog_items_by_name_view.render().el)
		if @catalog_items_by_part_number.length
			frag.appendChild(@catalog_items_by_part_number_view.render().el)
		@items.append(frag)
		@