class Quota.Views.ShowCatalogItem extends Quota.Views.PageBodyBlock

	# template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@catalog_item_children = options.catalog_item_children
		
		@manufacturers = options.manufacturers
		
		# @companies = new Quota.Collections.Companies()
		# 		@companies.on('reset', @companiesReset, @)
		# 		@companies.fetch()
		@_childItemsView = new Quota.Views.ShowCatalogItemChildItems({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@catalog_item_children, manufacturers: @manufacturers, vent: @vent})
		@vent.on('catalog_item_child_items:add_new_catalog_item_successful', @addNewCatalogItem_Success, @)
		
		
	render: ->
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		@container_child_items = @$('#child_items_container')
		
		@_childItemsView.setElement(@container_child_items).render()
		@
		
	setup: ->
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		@container_child_items = $('#child_items_container')
		
		@_childItemsView.setElement(@container_child_items).render()
		
	manufacturersReset: ->
		@_childItemsView.setElement(@container_child_items).render()
		
	
	addNewCatalogItem_Success: (obj) ->
		self = @
		if obj.model.get("manufacturer") and self.manufacturers.where(name: obj.model.get("manufacturer")).length == 0
			manufacturer = new Quota.Models.Manufacturer({manufacturer: obj.model.get("manufacturer")})
			self.manufacturers.add(manufacturer)