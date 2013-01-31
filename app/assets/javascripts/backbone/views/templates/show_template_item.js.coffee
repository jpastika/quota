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
		"focus input" : "handleFocus"
		"click .template_item_name_holder": "handleNameHolderClick"
		"click .template_item_part_number_holder": "handlePartNumberHolderClick"
		"click .template_item_quantity_holder": "handleQuantityHolderClick"
		"click .template_item_unit_price_holder": "handleUnitPriceHolderClick"
		"click .template_item_unit_price_unit_holder": "handleUnitPriceUnitHolderClick"
		"click .template_item_total_holder": "handleTotalHolderClick"
		"click .template_item_description_holder": "handleDescriptionHolderClick"
		"keydown .template_item_hide_package_contents": "handleHidePackageContentsInputKeyDown"
		# "keydown .template_item_name": "handleNameInputKeyDown"
		"focus .template_item_name_shim": "handleNameHolderClick"
		# 	"focus .template_item_part_number_shim": "handlePartNumberHolderClick"
		"focus .template_item_description_shim": "handleDescriptionHolderClick"
		"click .template_item_is_group_heading": "handleGroupHeadingClick"
		"click .template_item_hide_package_contents": "handleHidePackageContentsClick"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@item = options.item
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.on('destroy', @remove, @)
		# @model.on('change', @modelChanged, @)
		@parent_model = options.parent_model
		
		@mode = "SHOW"
		
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
		@input_template_item_unit_price_unit = @$('.template_item_unit_price_unit')
		@input_template_item_total = @$('.template_item_total')
		@input_template_item_description = @$('.template_item_description')
		@input_template_item_is_group_heading = @$('.template_item_is_group_heading')
		@input_template_item_hide_package_contents = @$('.template_item_hide_package_contents')
		@input_template_item_not_in_total = @$('.template_item_not_in_total')
		@input_template_item_catalog_item_key = @$('.template_item_catalog_item_key')
		
		@name_holder = @$('.template_item_name_holder')
		@part_number_holder = @$('.template_item_part_number_holder')
		@quantity_holder = @$('.template_item_quantity_holder')
		@description_holder = @$('.template_item_description_holder')
		@unit_price_holder = @$('.template_item_unit_price_holder')
		@unit_price_unit_holder = @$('.template_item_unit_price_unit_holder')
		@total_holder = @$('.template_item_total_holder')
		@total_unit_holder = @$('.template_item_total_unit_holder')
		@name_shim = @$('.template_item_name_shim')
		@description_shim = @$('.template_item_description_shim')
		
		@item_show = @$('.template-item-row-show')
		@item_edit = @$('.template-item-row-edit')
		@details_show = @$('.template-item-row-show-details')
		@details_edit = @$('.template-item-row-edit-details')
		@details_toggle = @$('.icon-cog')
		@package_toggle_down = @$('.icon-sort-down')
		@package_toggle_up = @$('.icon-sort-up')
		@package_contents = @$('.template-item-row-package-contents')
		@package_contents_list = @$('.template-item-row-package-contents td ul')
		@spinner = @$('.icon-spinner')
		@hide_package_contents_container = @$('.template_item_hide_package_contents_container')
		
		
		@_catalogItemComboView.el = @input_template_item_name
		@_catalogItemComboView.render()
		
		if @hideRemove
			@$('.template_item_remove').css('visibility', 'hidden')
			
		if @model.get("is_group_heading")
			$(@el).addClass('template_item_group_heading')
		
		@handleItemType()
		@decorateShow()
		@
		
	decorateShow: ->
		@decorateUnitPrice()
		@decorateUnitPriceUnit()
		@decorateTotal()
		@decorateTotalUnit()
		true
	
	decorateUnitPrice: ->
		@unit_price_holder.html(accounting.formatMoney(@model.get("unit_price"), "$ "))
		
	decorateUnitPriceUnit: ->
		# @unit_price_unit_holder.html()

	decorateTotal: ->
		@total_holder.html(accounting.formatMoney(@model.get("total"), "$ "))

	decorateTotalUnit: ->
		# @unit_price_holder.html(accounting.formatMoney(@model.get("unit_price")), "$")

	setHolders: ->
		@setNameHolder()
		@setPartNumberHolder()
		@setQuantityHolder()
		@setUnitPriceHolder()
		@setUnitPriceUnitHolder()
		@setTotalHolder()
		@setTotalUnitHolder()
		@setDescriptionHolder()
		true
	
	setNameHolder: ->
		@name_holder.html(@model.get('name'))
		true
	
	setPartNumberHolder: ->
		@part_number_holder.html(@model.get('part_number'))
		true
		
	setQuantityHolder: ->
		@quantity_holder.html(@model.get('quantity'))
		true
		
	setUnitPriceHolder: ->
		@unit_price_holder.html(@model.get('unit_price'))
		true
		
	setUnitPriceUnitHolder: ->
		@unit_price_unit_holder.html(@model.get('unit_price_unit'))
		true
		
	setTotalHolder: ->
		@total_holder.html(@model.get('total'))
		true
				
	setTotalUnitHolder: ->
		@total_unit_holder.html(@model.get('total_unit'))
		true
	
	setDescriptionHolder: ->
		@description_holder.html(@model.get('description'))
		true
	
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
		
	doShowMode: ->
		if @mode == "EDIT"
			@item_show.show()
			@item_edit.hide()
			@details_show.show()
			@details_edit.hide()
			@mode = "SHOW"
		true

	doEditMode: ->
		if @mode == "SHOW"
			@item_edit.show()
			@item_show.hide()
			@details_edit.show()
			@details_show.hide()
			@mode = "EDIT"
		true
		
	toggleMode: ->
		if @mode == "SHOW"
			@doEditMode()
		else
			@doShowMode()
		true
		
	handleFocus: ->
		@vent.trigger('template_items:set_focus', {view: @})

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
		# @details.toggle()
		@toggleMode()
		
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
		@doEditMode()
		@input_template_item_name.focus()
		true
		
	handlePartNumberHolderClick: ->
		@doEditMode()
		@input_template_item_part_number.focus()
		true

	handleQuantityHolderClick: ->
		@doEditMode()
		@input_template_item_quantity.focus()
		true
	
	handleUnitPriceHolderClick: ->
		@doEditMode()
		@input_template_item_unit_price.focus()
		true
	
	handleUnitPriceUnitHolderClick: ->
		@doEditMode()
		@input_template_item_unit_price_unit.focus()
		true

	handleTotalHolderClick: ->
		@doEditMode()
		@input_template_item_total.focus()
		true

	handleDescriptionHolderClick: ->
		@doEditMode()
		@input_template_item_description.focus()
		true

	handleNameInputKeyDown: (e)->
		if !e.shiftKey
			true
		else
			switch e.keyCode
				when 9
					@input_template_item_name.blur()
					# @doShowMode()
					# true
				else
					true
	
	handleHidePackageContentsInputKeyDown: (e)->
		if !e.shiftKey
			switch e.keyCode
				when 9
					@doShowMode()
					true
				else
					true
		else
			true

	showHidePackageContents: ->
		# @input_template_item_hide_package_contents.attr('checked', false)
		@package_contents.removeClass('hide_package_contents')
		@hide_package_contents_container.show()

	hideHidePackageContents: ->
		# @input_template_item_hide_package_contents.attr('checked', false)
		@package_contents.removeClass('hide_package_contents')
		@hide_package_contents_container.hide()

	handleGroupHeadingClick: ->
		if @input_template_item_is_group_heading.is(':checked')
			$(@el).addClass('template_item_group_heading')
		else
			$(@el).removeClass('template_item_group_heading')
		@saveModel()
			
	handleHidePackageContentsClick: ->
		if @input_template_item_hide_package_contents.is(':checked')
			@package_contents.addClass('hide_package_contents')
			# @hidePackageContents()
		else
			@package_contents.removeClass('hide_package_contents')
		@saveModel()
		
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
			@unit_price_holder.html(obj.catalog_item.list_price)
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
			@unit_price_holder.html('')
			# @input_template_item_unit_price_unit.html('')
			@updateTotal()
			@input_template_item_description.val('')
			@description_holder.html('')
			@input_template_item_catalog_item_key.val('')
		
		@decorateShow()
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
				unit_price_unit: @input_template_item_unit_price_unit.val()
				is_group_heading: @input_template_item_is_group_heading.is(':checked')
				not_in_total: @input_template_item_not_in_total.is(':checked')
				hide_package_contents: @input_template_item_hide_package_contents.is(':checked')
				total: @input_template_item_total.val()
				description: @input_template_item_description.val()
				catalog_item_key: @input_template_item_catalog_item_key.val()
				template_key: @parent_model.get("pub_key")
				# sort_order: @template_items.length
			},
			{
				error: ->
					self.hideSpinner()
					# console.log "save error"
				success: (model) -> 
					# self.vent.trigger('template_items:add_new_template_item_successful', {model: model})
					self.setHolders()
					self.updateTotal()
					self.decorateShow()
					self.hideSpinner()
			}
		)
		
	setCatalogItem: (catalog_item)->
		@catalog_item = catalog_item
		
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
		view = new Quota.Views.ShowTemplateItemPackageItem({model: item, tagName:'li', vent: @vent})
		# @_itemViews.push(view)
		view
		
	clearPackageContents: ->
		@package_contents_list.empty()

	handleItemType: ->
		if @catalog_item && @catalog_item.get("is_package") == true
			@showPackageToggle()
			@showHidePackageContents()
			@loadPackageContents()
		else
			@hidePackageToggle()
			@hideHidePackageContents()
			@clearPackageContents()