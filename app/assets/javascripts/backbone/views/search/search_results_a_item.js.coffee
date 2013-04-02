class Quota.Views.SearchResultsItem extends Backbone.View

	events:
		"click" : "handleClick"
		# "click .icon-remove": "destroy"
		# 		"click .catalog_item_link": "catalogItemLinkClicked"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		$(@el).html(@template({item:@model.toJSON()}))
		@