class Quota.Views.ShowTemplateItem2_Package extends Quota.Views.ShowTemplateItem2

	template: HandlebarsTemplates['template/show_template_item2_package'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-sort-down": "togglePackageContents"
		"click .icon-remove": "destroy"
		"click .icon-cog": "toggleDetails"
		"change .template_item_quantity": "updateTotal"
		"change .template_item_unit_price": "updateTotal"
		"change .template_item_catalog_item_key": "checkItemType"
		"drop": "dropped"
		"blur input" : "saveModel"
		
	render: ->
		$(@el).html(@template({template_item:@model.toJSON()}))
		
		
		@input_template_item_name = @$('.template_item_name')
		@input_template_item_part_number = @$('.template_item_part_number')
		@input_template_item_quantity = @$('.template_item_quantity')
		@input_template_item_unit_price = @$('.template_item_unit_price')
		# @input_template_item_unit_price_unit = @$('.template_item_unit_price_unit')
		@input_template_item_total = @$('.template_item_total')
		@input_template_item_description = @$('.template_item_description')
		# @input_template_item_is_group_heading = @$('.template_item_is_group_heading')
		# @input_template_item_not_in_total = @$('.template_item_not_in_total')
		@input_template_item_catalog_item_key = @$('.template_item_catalog_item_key')
		
		@details = @$('.template-item-row-details')
		@package_contents = @$('.template-item-row-package-contents')
		
		
		@_catalogItemComboView.el = @input_template_item_name
		@_catalogItemComboView.render()
		
		if @hideRemove
			@$('.template_item_remove').css('visibility', 'hidden')
		@
		
	togglePackageContents: () ->
		@package_contents.toggle();