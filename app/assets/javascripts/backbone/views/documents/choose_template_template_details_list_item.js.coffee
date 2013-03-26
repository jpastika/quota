class Quota.Views.ChooseTemplateTemplateDetailsListItem extends Backbone.View

	template: HandlebarsTemplates['documents/choose_template_template_details_list_item'] #Handlebars.compile($("#quote-document").html()) #JST['quotes/index']
	
	# events:
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@item = options.item
		@vent = options.vent
		# @model.on('change', @modelChanged, @)
		@parent_model = options.parent_model
		
		# if @model.get("catalog_item_key")
		# 			@setCatalogItem(new Quota.Models.CatalogItem(@model.get("catalog_item")))
		# 			
		# 		@_catalogItemComboView = new Quota.Views.CatalogItemComboView({parent_model:@model, source: "name", val: "name", className: 'string required', vent: @vent})
		# 		@_catalogItemComboView.on("catalog_item_combo:item_selected", @catalogItemSelected)
		

	render: ->
		$(@el).html(@template({template_item:@model.toJSON()}))
		
		# @_catalogItemComboView.el = @input_document_item_name
		# 		@_catalogItemComboView.render()
		# 		
		# 		if @model.get("is_group_heading")
		# 			$(@el).addClass('template_item_group_heading')
		# 		
		@total_holder = @$('.total_holder')
		@total_unit_holder = @$('.total_unit_holder')
		
		@handleItemType()
		@decorateShow()
		@
		
	decorateShow: ->
		# @decorateUnitPrice()
		# @decorateUnitPriceUnit()
		@decorateTotal()
		@decorateTotalUnit()
		true
	
	decorateUnitPrice: ->
		@unit_price_holder.html(accounting.formatMoney(@model.get("unit_price"), "$ "))
		
	decorateUnitPriceUnit: ->
		# @unit_price_unit_holder.html()

	decorateTotal: ->
		if @model.get("total") != "" and @model.get("total") != null
			@total_holder.html(accounting.formatMoney(@model.get("total"), "$ "))
		else
			@total_holder.html("")

	decorateTotalUnit: ->
		# @unit_price_holder.html(accounting.formatMoney(@model.get("unit_price")), "$")

	loadPackageContents: ->
		self = @
		@showSpinner()
		catalog_item = new Quota.Models.CatalogItem({pub_key: @catalog_item.get("pub_key")})
		catalog_item.fetch(
			{
				error: ->
					self.hideSpinner()
					# console.log "unable to retrieve package contents"
				success: (model, response, options) -> 
					self.setPackageContents(model)
					self.hideSpinner()
			}
		)
	
	setPackageContents: (model)->
		@package_items = new Quota.Collections.CatalogItems(model.get("child_items"))
		@renderPackageContents()
	
	renderPackageContents: ->
		frag = document.createDocumentFragment()
		frag.appendChild(@addOnePackageItem(item).render().el) for item in @package_items.models
		@package_contents_list.append(frag)

	addOnePackageItem: (item)->
		view = new Quota.Views.ShowDocumentItemPackageItem({model: item, tagName:'li', vent: @vent})
		# @_itemViews.push(view)
		view
		
	handleItemType: ->
		if @catalog_item && @catalog_item.get("is_package") == true
			# @showPackageToggle()
			# 			@showHidePackageContents()
			# @loadPackageContents()
		else
			# @hidePackageToggle()
			# 			@hideHidePackageContents()
			# @clearPackageContents()