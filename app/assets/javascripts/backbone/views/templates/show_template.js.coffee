class Quota.Views.ShowTemplate extends Quota.Views.PageBodyBlock

	# template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@template_items = options.template_items
		
		# @companies = new Quota.Collections.Companies()
		# 		@companies.on('reset', @companiesReset, @)
		# 		@companies.fetch()
		@_productsView = new Quota.Views.ShowTemplateProducts({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@template_items, vent: @vent})
		@vent.on('template_products:add_new_product_successful', @addNewProduct_Success, @)
		
		
	render: ->
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		@container_products = @$('#products_container')
		
		@_productsView.setElement(@container_products).render()
		@
		
	setup: ->
		# $(@el).html(@template({opportunity:@model.toJSON()}))
		@container_products = $('#products_container')
		
		@_productsView.setElement(@container_products).render()
		
	manufacturersReset: ->
		@_productsView.setElement(@container_products).render()
		
	
	addNewProduct_Success: (obj) ->
		self = @
		# if obj.model.get("manufacturer") and self.manufacturers.where(name: obj.model.get("manufacturer")).length == 0
		# 			manufacturer = new Quota.Models.Manufacturer({manufacturer: obj.model.get("manufacturer")})
		# 			self.manufacturers.add(manufacturer)