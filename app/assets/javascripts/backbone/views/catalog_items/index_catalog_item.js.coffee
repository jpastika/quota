class Quota.Views.IndexCatalogItem extends Backbone.View

	template: HandlebarsTemplates['catalog_items/index_catalog_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .catalog_item_remove": "destroy"
		"click .catalog_item_link": "catalogItemLinkClicked"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@catalog_item = options.catalog_item
		@vent = options.vent
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({catalog_item:@model.toJSON()}))
		@
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	toggle: () ->
		$(@el).toggle()
		
	catalogItemLinkClicked: ->
		@vent.trigger("catalog_item_link:clicked", {view: @})