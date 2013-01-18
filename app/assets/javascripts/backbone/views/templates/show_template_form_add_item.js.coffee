class Quota.Views.ShowTemplateFormAddItem extends Backbone.View

	template: HandlebarsTemplates['template/show_template_form_add_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:	
		"change .template_item_quantity input": "updateTotal"
		"change .template_item_unit_price input": "updateTotal"
	# 		"click #catalog_search": "clickCatalogSearch"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_item:clicked', @showAddItem, @)
		@vent.on('done_add_item:clicked', @hideAddItem, @)
		@vent.on('template_items:remove_item', @removeTemplateItem, @)
		@vent.on('template_items:add_new_template_item', @addNewTemplateItem, @)
		@vent.on('catalog_item_combo:item_selected', @addNewItemCatalogItemSelected, @)
		# @manufacturers = options.manufacturers
		
		@template_model = options.parent_model
		@template_items = options.parent_collection
		@catalog_items = options.catalog_items
		
		# @_itemsView = new Quota.Views.CatalogItemSearchList({parent_child_key: @catalog_item.get("pub_key"), vent: @vent})
		
	render: ->
		$(@el).html(@template({template:@template_model}))
		
		@_catalogItemComboView = new Quota.Views.CatalogItemComboView({parent_model:@model, collection:@catalog_items, el: '#template_item_name', source: "name", val: "name", className: 'string required', vent: @vent})
		@_catalogItemComboView.render()
		
		# @manufacturer_name = $('#catalog_item_manufacturer')
		# 		@input_manufacturer_name = $('#catalog_item_manufacturer')
		# 		@input_manufacturer_key = $('.manufacturer_key')
		# 		manufacturer_name_field_name = @input_manufacturer_name.attr('name')
		# 		manufacturer_name_field_id = @input_manufacturer_name.attr('id')
		# 		
		# 		@_manufacturerComboView = new Quota.Views.ManufacturerComboView({parent_model:@model, collection:@manufacturers, el: '#catalog_item_manufacturer', source: "manufacturer", val: "manufacturer", className: 'string input-large', vent: @vent})
		# 		@_manufacturerComboView.render()
		# 		
		# 		@input_manufacturer_name = $('#catalog_item_manufacturer')
		# 				
		# 		@input_manufacturer_name.attr('name', manufacturer_name_field_name)
		# 		@input_manufacturer_name.attr('id', manufacturer_name_field_id)
		# 		
		# 		@input_catalog_item_name = @$('.catalog_item_name input')
		# 		@input_catalog_item_manufacturer_name = @$('.catalog_item_manufacturer input')
		# 		@input_catalog_item_part_number = @$('.catalog_item_part_number input')
		# 		@input_catalog_item_list_price = @$('#catalog_item_list_price')
		# 		@input_catalog_item_list_price_interval = @$('#catalog_item_recurring_unit')
		# 		@input_catalog_item_is_taxable = @$('#catalog_item_is_taxable')
		# 		@input_catalog_item_is_package = @$('#catalog_item_is_package')
		# 		
		# 		@input_catalog_search = @$('.catalog_search input')
		
		@input_template_item_name = @$('.template_item_name input')
		@input_template_item_part_number = @$('.template_item_part_number input')
		@input_template_item_quantity = @$('.template_item_quantity input')
		@input_template_item_unit_price = @$('.template_item_unit_price input')
		@input_template_item_unit_price_unit = @$('.template_item_unit_price_unit')
		@input_template_item_total = @$('.template_item_total input')
		@input_template_item_description = @$('.template_item_description textarea')
		@input_template_item_is_group_heading = @$('.template_item_is_group_heading input')
		@input_template_item_not_in_total = @$('.template_item_not_in_total input')
		
		
		@loading = @$('.section-loading')
		@
		
	show: ->
		$(@el).toggle(true)
		
	hide: ->
		$(@el).toggle(false)
		
	showAddItem: ->
		@show()
		
	hideAddItem: ->
		@hide()
	
	clicked: ->
	
	# manufacturersReset: ->
	# 		# @vent.trigger('manufacturers:loaded')
	# 		# 		@_manufacturerComboView.setElement(@manufacturer_name).render()
	# 		
	showLoading: ->
		@loading.toggle(true)

	hideLoading: ->
		@loading.toggle(false)
		
	addNewTemplateItem: ->
		self = @
		template_item = new Quota.Models.TemplateItem()
		    
		template_item.save(
			{
				name: @input_template_item_name.val()
				part_number: @input_template_item_part_number.val()
				unit_price: @input_template_item_unit_price.val()
				quantity: @input_template_item_quantity.val()
				unit_price_unit: @input_template_item_unit_price_unit.html()
				is_group_heading: @input_template_item_is_group_heading.is(':checked')
				not_in_total: @input_template_item_not_in_total.is(':checked')
				total: @input_template_item_total.val()
				description: @input_template_item_description.val()
				template_key: @template_model.get("pub_key")
				sort_order: @template_items.length
			},
			{
				error: ->
					console.log "save error"
				success: (model) -> 
					self.template_items.add(model)
					self.vent.trigger('template_items:add_new_template_item_successful', {model: model})
					self.resetAddNewItemForm()
			}
		)
		
	addNewItemCatalogItemSelected: (obj)->
		if obj.catalog_item.pub_key
			@input_template_item_name.val(obj.catalog_item.name)
			@input_template_item_part_number.val(obj.catalog_item.part_number)
			@input_template_item_unit_price.val(obj.catalog_item.list_price)
			@input_template_item_unit_price_unit.html(obj.catalog_item.recurring_unit)
			@updateTotal()
			@input_template_item_description.val(obj.catalog_item.description)
		else
			@input_template_item_name.val(obj.catalog_item.name)
			@input_template_item_part_number.val('')
			@input_template_item_unit_price.val(0)
			@input_template_item_unit_price_unit.html('')
			@input_template_item_total.val(@calcTotal())
			@input_template_item_description.val('')
			
	
	calcTotal: ->
		@input_template_item_quantity.val() * @input_template_item_unit_price.val()
		
	updateTotal: ->
		@input_template_item_total.val(@calcTotal())
		
	
	removeTemplateItem: (item)->
		# @_contactsView.setElement(@container_contacts).render()
		
	renderSearchResults: (collection)->
		@_itemsView.collection = collection
		@container_search_item_list = @$('#catalog_search_container')
		@_itemsView.setElement(@container_search_item_list).render()
		
		
	resetAddNewItemForm: ->
		@input_template_item_name.val('')
		@input_template_item_part_number.val('')
		@input_template_item_unit_price.val(0)
		@input_template_item_unit_price_unit.html('')
		@input_template_item_total.val(0)
		@input_template_item_description.val('')
		@input_template_item_is_group_heading.attr('checked', false)
		@input_template_item_not_in_total.attr('checked', false)