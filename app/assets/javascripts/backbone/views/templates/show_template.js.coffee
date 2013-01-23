class Quota.Views.ShowTemplate extends Quota.Views.PageBodyBlock

	# template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@template_items = options.template_items
		@vent.on('template_items:add_new_item_successful', @addNewItem_Success, @)
		
		@_itemsView = new Quota.Views.ShowTemplateItems({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@template_items, vent: @vent})
		
	render: ->
		@container_items = @$('#items_container')
		
		@_itemsView.setElement(@container_items2).render()
		@
		
	setup: ->
		@container_items = $('#items_container')
		
		@_itemsView.setElement(@container_items).render()
		
	addNewItem_Success: (obj) ->
		self = @
		