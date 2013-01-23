class Quota.Views.ShowTemplateItem extends Backbone.View

	template: HandlebarsTemplates['template/show_template_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-sort-down": "showPackageContents"
		"click .icon-sort-up": "hidePackageContents"
		"click .icon-remove": "destroy"
		"click .icon-cog": "toggleDetails"
		"change .template_item_quantity": "updateTotal"
		"change .template_item_unit_price": "updateTotal"
		"drop": "dropped"
		"blur input" : "saveModel"
		"click .template_item_name_holder": "handleNameHolderClick"
		"blur .template_item_name": "handleNameInputBlur"
		"click .template_item_part_number_holder": "handlePartNumberHolderClick"
		"blur .template_item_part_number": "handlePartNumberInputBlur"
		"click .template_item_description_holder": "handleDescriptionHolderClick"
		"blur .template_item_description": "handleDescriptionInputBlur"
		"keydown .template_item_name": "handleNameInputKeyDown"
		"focus .template_item_name_shim": "handleNameHolderClick"
		"focus .template_item_part_number_shim": "handlePartNumberHolderClick"
		"focus .template_item_description_shim": "handleDescriptionHolderClick"
		"click .template_item_is_group_heading": "handleGroupHeadingClick"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@item = options.item
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.on('destroy', @remove, @)
		# @model.on('change', @modelChanged, @)
		@parent_model = options.parent_model
		
		if @model.get("catalog_item_key")
			@setCatalogItem(new Quota.Models.CatalogItem(@model.get("catalog_item")))
			
		@_catalogItemComboView = new Quota.Views.CatalogItemComboView({parent_model:@model, source: "name", val: "name", className: 'string required', vent: @vent})
		@_catalogItemComboView.on("catalog_item_combo:item_selected", @catalogItemSelected)
		

	render: ->
		$(@el).html(@template({template_item:@model.toJSON()}))
		
		@input_template_item_name = @$('.template_item_name')
		@input_template_item_part_number = @$('.template_item_part_number')
		@input_template_item_quantity = @$('.template_item_quantity')
		@input_template_item_unit_price = @$('.template_item_unit_price')
		# @input_template_item_unit_price_unit = @$('.template_item_unit_price_unit')
		@input_template_item_total = @$('.template_item_total')
		@input_template_item_description = @$('.template_item_description')
		@input_template_item_is_group_heading = @$('.template_item_is_group_heading')
		@input_template_item_not_in_total = @$('.template_item_not_in_total')
		@input_template_item_catalog_item_key = @$('.template_item_catalog_item_key')
		
		@name_holder = @$('.template_item_name_holder')
		@part_number_holder = @$('.template_item_part_number_holder')
		@description_holder = @$('.template_item_description_holder')
		@name_shim = @$('.template_item_name_shim')
		@part_number_shim = @$('.template_item_part_number_shim')
		@description_shim = @$('.template_item_description_shim')
		
		@details = @$('.template-item-row-details')
		@details_toggle = @$('.icon-cog')
		@package_toggle_down = @$('.icon-sort-down')
		@package_toggle_up = @$('.icon-sort-up')
		@package_contents = @$('.template-item-row-package-contents')
		@spinner = @$('.icon-spinner')
		
		
		@_catalogItemComboView.el = @input_template_item_name
		@_catalogItemComboView.render()
		
		if @hideRemove
			@$('.template_item_remove').css('visibility', 'hidden')
		
		@handleItemType()
		@

	destroy: (evt) ->
		$(@el).toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		@vent.trigger('template_items:remove_template_item', {model: @model})
		
	hideRemove: ->
		@hideRemove = true
		$(@el).find('.template_item_remove').css('visibility', 'hidden')

	showRemove: ->
		@hideRemove = false
		$(@el).find('.template_item_remove').css('visibility', '')
		
	hideSpinner: ->
		@spinner.hide()

	showSpinner: ->
		@spinner.show()
		
	toggleSpinner: ->
		@spinner.toggle()

	hideDetailsToggle: ->
		@details_toggle.hide()

	showDetailsToggle: ->
		@details_toggle.show()

	toggleDetailsToggle: ->
		@details_toggle.toggle()

	hidePackageToggle: ->
		@hidePackageContents()
		@package_toggle_down.hide()

	showPackageToggle: ->
		@hidePackageContents()
		@package_toggle_down.show()

	togglePackageToggle: ->
		@package_toggle.toggle()

	toggleDetails: ->
		@details.toggle()
		
	togglePackageContents: ->
		@package_contents.toggle()
		
	showPackageContents: ->
		@package_contents.show()
		@package_toggle_down.hide()
		@package_toggle_up.show()
		
	hidePackageContents: ->
		@package_contents.hide()
		@package_toggle_up.hide()
		@package_toggle_down.show()
		
	handleNameHolderClick: ->
		@hideNameHolder()
		@showNameInput()
		@input_template_item_name.focus()
		@name_shim.hide()
		true
		
	handleNameInputBlur: ->
		@hideNameInput()
		@showNameHolder()
		@name_holder.html(@input_template_item_name.val())
		@name_shim.show()
		true
		
	hideNameHolder: ->
		@name_holder.hide()
		
	showNameHolder: ->
		@name_holder.show()
		
	hideNameInput: ->
		@input_template_item_name.hide()
		
	showNameInput: ->
		@input_template_item_name.show()
		
	handlePartNumberHolderClick: ->
		@hidePartNumberHolder()
		@showPartNumberInput()
		@input_template_item_part_number.focus()
		@part_number_shim.hide()
		true

	handlePartNumberInputBlur: ->
		@hidePartNumberInput()
		@showPartNumberHolder()
		@part_number_holder.html(@input_template_item_part_number.val())
		@part_number_shim.show()
		true

	hidePartNumberHolder: ->
		@part_number_holder.hide()

	showPartNumberHolder: ->
		@part_number_holder.show()

	hidePartNumberInput: ->
		@input_template_item_part_number.hide()

	showPartNumberInput: ->
		@input_template_item_part_number.show()
	
	handleDescriptionHolderClick: ->
		@hideDescriptionHolder()
		@showDescriptionInput()
		@input_template_item_description.focus()
		@description_shim.hide()
		true

	handleDescriptionInputBlur: ->
		@hideDescriptionInput()
		@showDescriptionHolder()
		@description_holder.html(@input_template_item_description.val())
		@description_shim.show()
		true

	hideDescriptionHolder: ->
		@description_holder.hide()

	showDescriptionHolder: ->
		@description_holder.show()

	hideDescriptionInput: ->
		@input_template_item_description.hide()

	showDescriptionInput: ->
		@input_template_item_description.show()

	handleNameInputKeyDown: (e)->
		if !e.shiftKey
			switch e.keyCode
				when 9
					@handlePartNumberInputBlur()
					@handlePartNumberHolderClick()
					false
				else
					true
		else
			true
			
	handleGroupHeadingClick: ->
		if @input_template_item_is_group_heading.is(':checked')
			$(@el).addClass('template_item_group_heading')
		else
			$(@el).removeClass('template_item_group_heading')
		
	dropped: (event, index) ->
		$(@el).trigger('update-sort', [this.model, index])
	
	catalogItemSelected: (obj)->
		@catalog_item = new Quota.Models.CatalogItem(obj.catalog_item)
		if obj.catalog_item.pub_key
			@setCatalogItem(@catalog_item)
			@input_template_item_name.val(obj.catalog_item.name)
			@name_holder.html(obj.catalog_item.name)
			@input_template_item_part_number.val(obj.catalog_item.part_number)
			@part_number_holder.html(obj.catalog_item.part_number)
			@input_template_item_unit_price.val(obj.catalog_item.list_price)
			# @input_template_item_unit_price_unit.html(obj.catalog_item.recurring_unit)
			@updateTotal()
			@input_template_item_description.val(obj.catalog_item.description)
			@description_holder.html(obj.catalog_item.description)
			@input_template_item_catalog_item_key.val(obj.catalog_item.pub_key)
		else
			@setCatalogItem(null)
			@input_template_item_name.val(obj.catalog_item.name)
			@name_holder.html(obj.catalog_item.name)
			@input_template_item_part_number.val('')
			@part_number_holder.html('')
			@input_template_item_unit_price.val(0)
			# @input_template_item_unit_price_unit.html('')
			@input_template_item_total.val(@calcTotal())
			@input_template_item_description.val('')
			@description_holder.html('')
			@input_template_item_catalog_item_key.val('')
		
		@handleItemType()


	calcTotal: ->
		@input_template_item_quantity.val() * @input_template_item_unit_price.val()

	updateTotal: ->
		@input_template_item_total.val(@calcTotal())
		
	saveModel: ->
		self = @
		@showSpinner()
		@model.save(
			{
				name: @input_template_item_name.val()
				part_number: @input_template_item_part_number.val()
				unit_price: @input_template_item_unit_price.val()
				quantity: @input_template_item_quantity.val()
				# unit_price_unit: @input_template_item_unit_price_unit.html()
				# is_group_heading: @input_template_item_is_group_heading.is(':checked')
				# not_in_total: @input_template_item_not_in_total.is(':checked')
				total: @input_template_item_total.val()
				description: @input_template_item_description.val()
				catalog_item_key: @input_template_item_catalog_item_key.val()
				template_key: @parent_model.get("pub_key")
				# sort_order: @template_items.length
			},
			{
				error: ->
					self.hideSpinner()
					console.log "save error"
				success: (model) -> 
					self.vent.trigger('template_items:add_new_template_item_successful', {model: model})
					self.hideSpinner()
			}
		)
		
	setCatalogItem: (catalog_item)->
		@catalog_item = catalog_item
		
	loadPackageContents: ->
		console.log "load contents"
		
	clearPackageContents: ->
		console.log "clear contents"

	handleItemType: ->
		if @catalog_item && @catalog_item.get("is_package") == true
			@showPackageToggle()
			@loadPackageContents()
		else
			@hidePackageToggle()
			@clearPackageContents()