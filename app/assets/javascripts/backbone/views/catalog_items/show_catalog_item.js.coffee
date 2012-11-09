class Quota.Views.ShowCatalogItem extends Quota.Views.PageBodyBlock

	# template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@child_items = @model.get("child_items")
		
		@manufacturers = options.manufacturers
		
		# @companies = new Quota.Collections.Companies()
		# 		@companies.on('reset', @companiesReset, @)
		# 		@companies.fetch()
		@_childItemsView = new Quota.Views.ShowCatalogItemChildItems({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@child_items, manufacturers: @manufacturers, vent: @vent})
		
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