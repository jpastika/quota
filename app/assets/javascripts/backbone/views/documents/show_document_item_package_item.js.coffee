class Quota.Views.ShowDocumentItemPackageItem extends Backbone.View

	document: HandlebarsTemplates['documents/show_document_item_package_item'] #Handlebars.compile($("#quote-document").html()) #JST['quotes/index']
	
	# events:
	# 		"click .icon-sort-down": "showPackageContents"
	# 		"click .icon-sort-up": "hidePackageContents"
	# 		"click .icon-remove": "destroy"
	# 		"click .icon-cog": "toggleDetails"
	# 		"change .document_item_quantity": "updateTotal"
	# 		"change .document_item_unit_price": "updateTotal"
	# 		"drop": "dropped"
	# 		"blur input" : "saveModel"
	# 		"click .document_item_name_holder": "handleNameHolderClick"
	# 		"blur .document_item_name": "handleNameInputBlur"
	# 		"click .document_item_part_number_holder": "handlePartNumberHolderClick"
	# 		"blur .document_item_part_number": "handlePartNumberInputBlur"
	# 		"click .document_item_description_holder": "handleDescriptionHolderClick"
	# 		"blur .document_item_description": "handleDescriptionInputBlur"
	# 		"keydown .document_item_name": "handleNameInputKeyDown"
	# 		"focus .document_item_name_shim": "handleNameHolderClick"
	# 		"focus .document_item_part_number_shim": "handlePartNumberHolderClick"
	# 		"focus .document_item_description_shim": "handleDescriptionHolderClick"
	# 		"click .document_item_is_group_heading": "handleGroupHeadingClick"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		# @item = options.item
		# 		@vent = options.vent
		# 		@hideRemove = if options.hideRemove then options.hideRemove else false
		# 		@model.on('destroy', @remove, @)
		# 		# @model.on('change', @modelChanged, @)
		# 		@parent_model = options.parent_model
		# 		
		# 		if @model.get("catalog_item_key")
		# 			@setCatalogItem(new Quota.Models.CatalogItem(@model.get("catalog_item")))
		# 			
		# 		@_catalogItemComboView = new Quota.Views.CatalogItemComboView({parent_model:@model, source: "name", val: "name", className: 'string required', vent: @vent})
		# 		@_catalogItemComboView.on("catalog_item_combo:item_selected", @catalogItemSelected)
		

	render: ->
		$(@el).html(@document({catalog_item:@model.toJSON()}))
		
		# @input_document_item_name = @$('.document_item_name')
		# 		@input_document_item_part_number = @$('.document_item_part_number')
		# 		@input_document_item_quantity = @$('.document_item_quantity')
		# 		@input_document_item_unit_price = @$('.document_item_unit_price')
		# 		# @input_document_item_unit_price_unit = @$('.document_item_unit_price_unit')
		# 		@input_document_item_total = @$('.document_item_total')
		# 		@input_document_item_description = @$('.document_item_description')
		# 		@input_document_item_is_group_heading = @$('.document_item_is_group_heading')
		# 		@input_document_item_not_in_total = @$('.document_item_not_in_total')
		# 		@input_document_item_catalog_item_key = @$('.document_item_catalog_item_key')
		# 		
		# 		@name_holder = @$('.document_item_name_holder')
		# 		@part_number_holder = @$('.document_item_part_number_holder')
		# 		@description_holder = @$('.document_item_description_holder')
		# 		@name_shim = @$('.document_item_name_shim')
		# 		@part_number_shim = @$('.document_item_part_number_shim')
		# 		@description_shim = @$('.document_item_description_shim')
		# 		
		# 		@details = @$('.document-item-row-details')
		# 		@details_toggle = @$('.icon-cog')
		# 		@package_toggle_down = @$('.icon-sort-down')
		# 		@package_toggle_up = @$('.icon-sort-up')
		# 		@package_contents = @$('.document-item-row-package-contents')
		# 		@spinner = @$('.icon-spinner')
		# 		
		# 		
		# 		@_catalogItemComboView.el = @input_document_item_name
		# 		@_catalogItemComboView.render()
		# 		
		# 		if @hideRemove
		# 			@$('.document_item_remove').css('visibility', 'hidden')
		# 		
		# 		@handleItemType()
		@

