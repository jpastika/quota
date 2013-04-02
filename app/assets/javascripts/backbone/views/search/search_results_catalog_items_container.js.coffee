class Quota.Views.SearchResultsCatalogItemsContainer extends Quota.Views.SearchResultsContainer

	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@catalog_items_by_name = options.catalog_items_by_name
		@catalog_items_by_part_number = options.catalog_items_by_part_number
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
	render: ->
		$(@el).html(@template({catalog_items_by_name:@catalog_items_by_name.toJSON(), catalog_items_by_part_number:@catalog_items_by_part_number.toJSON(), title: "Catalog Items", cnt: (@catalog_items_by_name.length + @catalog_items_by_part_number.length)}))
		@