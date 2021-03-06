class Quota.Views.ShowCatalogItemChildItem extends Backbone.View

	template: HandlebarsTemplates['catalog_items/show_catalog_item_child_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-remove": "destroy"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@item = options.item
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.on('destroy', @remove, @)

	render: ->
		$(@el).html(@template({catalog_item_child_item:@model.toJSON()}))
		@list_price = @$('.catalog_item_child_item_list_price')
		@list_price.html(accounting.formatMoney(@model.get("child_item").unit_price, "$ "))
		if @hideRemove
			@$('.child_item_remove').css('visibility', 'hidden')
		@

	destroy: (evt) ->
		$(@el).toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		@vent.trigger('catalog_item_child_items:remove_child_item', {model: @model})
		

	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.child_item_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		$(@el).find('.child_item_remove').css('visibility', '')