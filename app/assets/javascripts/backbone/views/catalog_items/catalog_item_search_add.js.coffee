class Quota.Views.CatalogItemSearchAdd extends Backbone.View

	template: HandlebarsTemplates['catalog_items/catalog_item_search_add'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .btn": "addItem"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		$(@el).html(@template({catalog_item:@model.toJSON()}))
		@
		
	addItem: ->
		# @remove()
		@vent.trigger("catalog_search_results:add_item", {catalog_item:@model, view: @})
		
	save: ->
		