class Quota.Views.ShowTemplateItemPackageItem extends Backbone.View

	template: HandlebarsTemplates['template/show_template_item_package_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	# events:
	# 		"click .icon-sort-down": "showPackageContents"
	# 		"click .icon-sort-up": "hidePackageContents"
	# 		"click .icon-remove": "destroy"
	# 		"click .icon-cog": "toggleDetails"
	# 		"change .template_item_quantity": "updateTotal"
	# 		"change .template_item_unit_price": "updateTotal"
	# 		"drop": "dropped"
	# 		"blur input" : "saveModel"
	# 		"click .template_item_name_holder": "handleNameHolderClick"
	# 		"blur .template_item_name": "handleNameInputBlur"
	# 		"click .template_item_part_number_holder": "handlePartNumberHolderClick"
	# 		"blur .template_item_part_number": "handlePartNumberInputBlur"
	# 		"click .template_item_description_holder": "handleDescriptionHolderClick"
	# 		"blur .template_item_description": "handleDescriptionInputBlur"
	# 		"keydown .template_item_name": "handleNameInputKeyDown"
	# 		"focus .template_item_name_shim": "handleNameHolderClick"
	# 		"focus .template_item_part_number_shim": "handlePartNumberHolderClick"
	# 		"focus .template_item_description_shim": "handleDescriptionHolderClick"
	# 		"click .template_item_is_group_heading": "handleGroupHeadingClick"
		
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
		$(@el).html(@template({catalog_item:@model.toJSON()}))
		
		# @input_template_item_name = @$('.template_item_name')
		# 		@input_template_item_part_number = @$('.template_item_part_number')
		# 		@input_template_item_quantity = @$('.template_item_quantity')
		# 		@input_template_item_unit_price = @$('.template_item_unit_price')
		# 		# @input_template_item_unit_price_unit = @$('.template_item_unit_price_unit')
		# 		@input_template_item_total = @$('.template_item_total')
		# 		@input_template_item_description = @$('.template_item_description')
		# 		@input_template_item_is_group_heading = @$('.template_item_is_group_heading')
		# 		@input_template_item_not_in_total = @$('.template_item_not_in_total')
		# 		@input_template_item_catalog_item_key = @$('.template_item_catalog_item_key')
		# 		
		# 		@name_holder = @$('.template_item_name_holder')
		# 		@part_number_holder = @$('.template_item_part_number_holder')
		# 		@description_holder = @$('.template_item_description_holder')
		# 		@name_shim = @$('.template_item_name_shim')
		# 		@part_number_shim = @$('.template_item_part_number_shim')
		# 		@description_shim = @$('.template_item_description_shim')
		# 		
		# 		@details = @$('.template-item-row-details')
		# 		@details_toggle = @$('.icon-cog')
		# 		@package_toggle_down = @$('.icon-sort-down')
		# 		@package_toggle_up = @$('.icon-sort-up')
		# 		@package_contents = @$('.template-item-row-package-contents')
		# 		@spinner = @$('.icon-spinner')
		# 		
		# 		
		# 		@_catalogItemComboView.el = @input_template_item_name
		# 		@_catalogItemComboView.render()
		# 		
		# 		if @hideRemove
		# 			@$('.template_item_remove').css('visibility', 'hidden')
		# 		
		# 		@handleItemType()
		@

	