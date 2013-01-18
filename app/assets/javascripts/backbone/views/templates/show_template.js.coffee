class Quota.Views.ShowTemplate extends Quota.Views.PageBodyBlock

	# template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@template_items = options.template_items
		@catalog_items = options.catalog_items
		
		# @companies = new Quota.Collections.Companies()
		# 		@companies.on('reset', @companiesReset, @)
		# 		@companies.fetch()
		
		# @_itemsView = new Quota.Views.ShowTemplateItems({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@template_items, catalog_items: @catalog_items, vent: @vent})
		@vent.on('template_items:add_new_item_successful', @addNewItem_Success, @)
		
		
		@_itemsView2 = new Quota.Views.ShowTemplateItems2({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@template_items, catalog_items: @catalog_items, vent: @vent})
		
	render: ->
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		# @container_items = @$('#items_container')
		@container_items2 = @$('#items_container2')
		
		# @_itemsView.setElement(@container_items).render()
		@_itemsView2.setElement(@container_items2).render()
		@
		
	setup: ->
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		# @container_items = $('#items_container')
		@container_items2 = $('#items_container2')
		
		# @_itemsView.setElement(@container_items).render()
		@_itemsView2.setElement(@container_items2).render()
		
	addNewItem_Success: (obj) ->
		self = @
		# if obj.model.get("manufacturer") and self.manufacturers.where(name: obj.model.get("manufacturer")).length == 0
		# 			manufacturer = new Quota.Models.Manufacturer({manufacturer: obj.model.get("manufacturer")})
		# 			self.manufacturers.add(manufacturer)