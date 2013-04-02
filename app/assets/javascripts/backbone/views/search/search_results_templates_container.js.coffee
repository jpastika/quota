class Quota.Views.SearchResultsTemplatesContainer extends Quota.Views.SearchResultsContainer

	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@templates_by_name = options.templates_by_name
		@templates_by_part_name = options.templates_by_part_name
		@templates_by_part_number = options.templates_by_part_number
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
	render: ->
		$(@el).html(@template({templates_by_name:@templates_by_name.toJSON(), templates_by_part_name:@templates_by_part_name.toJSON(), templates_by_part_number:@templates_by_part_number.toJSON(), title: "Templates", cnt: (@templates_by_name.length + @templates_by_part_name.length + @templates_by_part_number.length)}))
		@