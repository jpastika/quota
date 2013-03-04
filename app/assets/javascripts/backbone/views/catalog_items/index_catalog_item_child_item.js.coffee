class Quota.Views.IndexCatalogItemChildItem extends Backbone.View

	template: HandlebarsTemplates['catalog_items/index_catalog_item_child_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click" : "handleClick"
		# "click .icon-remove": "destroy"
		# 		"click .catalog_item_link": "catalogItemLinkClicked"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		$(@el).html(@template({child_item:@model.toJSON()}))
		@
	
	handleClick: (evt) ->
		self = @
		
		@catalogItemLinkClicked()
		
	catalogItemLinkClicked: ->
		# console.log "clicked"
		window.location.href="/catalog/#{@model.get("pub_key")}"
		# @vent.trigger("catalog_item_link:clicked", {view: @})