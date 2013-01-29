class Quota.Views.ShowTemplateFormAddItem extends Backbone.View

	template: HandlebarsTemplates['template/show_template_form_add_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-sort-down": "showPackageContents"
		"click .icon-sort-up": "hidePackageContents"
		"click .icon-cog": "toggleDetails"
		"click .icon-ok": "saveModel"
		"change .template_item_quantity": "updateTotal"
		"change .template_item_unit_price": "updateTotal"
		# "click .template_item_name_holder": "handleNameHolderClick"
		# "blur .template_item_name": "handleNameInputBlur"
		# "click .template_item_part_number_holder": "handlePartNumberHolderClick"
		# "blur .template_item_part_number": "handlePartNumberInputBlur"
		# "click .template_item_description_holder": "handleDescriptionHolderClick"
		# "blur .template_item_description": "handleDescriptionInputBlur"
		# "keydown .template_item_name": "handleNameInputKeyDown"
		"click .template_item_is_group_heading": "handleGroupHeadingClick"
		"click .template_item_hide_package_contents": "handleHidePackageContentsClick"
			
	initialize: (options)->
		self = @
		_.bindAll(@)
		@item = options.item
		@vent = options.vent
		@parent_model = options.parent_model
		
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
		@input_template_item_hide_package_contents = @$('.template_item_hide_package_contents')
		@input_template_item_catalog_item_key = @$('.template_item_catalog_item_key')
		
		# @name_holder = @$('.template_item_name_holder')
		# 		@part_number_holder = @$('.template_item_part_number_holder')
		# 		@description_holder = @$('.template_item_description_holder')
		
		@details = @$('.template-item-row-details')
		@details_toggle = @$('.icon-cog')
		@package_toggle_down = @$('.icon-sort-down')
		@package_toggle_up = @$('.icon-sort-up')
		@package_contents = @$('.template-item-row-package-contents')
		@package_contents_list = @$('.template-item-row-package-contents td ul')
		@spinner = @$('.icon-spinner')
		@hide_package_contents_container = @$('.template_item_hide_package_contents_container')
		
		@_catalogItemComboView.el = @input_template_item_name
		@_catalogItemComboView.render()
		
		@

	hideSpinner: () ->
		@spinner.hide()

	showSpinner: () ->
		@spinner.show()

	toggleSpinner: () ->
		@spinner.toggle()

	hideDetailsToggle: () ->
		@details_toggle.hide()

	showDetailsToggle: () ->
		@details_toggle.show()

	toggleDetailsToggle: () ->
		@details_toggle.toggle()

	hidePackageToggle: () ->
		@hidePackageContents()
		@package_toggle_down.hide()

	showPackageToggle: () ->
		@hidePackageContents()
		@package_toggle_down.show()

	togglePackageToggle: () ->
		@package_toggle.toggle()

	toggleDetails: () ->
		@details.toggle()

	togglePackageContents: () ->
		@package_contents.toggle()

	showPackageContents: () ->
		@package_contents.show()
		@package_toggle_down.hide()
		@package_toggle_up.show()

	hidePackageContents: () ->
		@package_contents.hide()
		@package_toggle_up.hide()
		@package_toggle_down.show()

	# handleNameHolderClick: ->
	# 		@hideNameHolder()
	# 		@showNameInput()
	# 		@input_template_item_name.focus()
	# 		true
	# 
	# 	handleNameInputBlur: ->
	# 		@hideNameInput()
	# 		@showNameHolder()
	# 		@name_holder.html(@input_template_item_name.val())
	# 		true

	# hideNameHolder: ->
	# 		@name_holder.hide()
	# 
	# 	showNameHolder: ->
	# 		@name_holder.show()
	# 
	# 	hideNameInput: ->
	# 		@input_template_item_name.hide()
	# 
	# 	showNameInput: ->
	# 		@input_template_item_name.show()

	# handlePartNumberHolderClick: ->
	# 		@hidePartNumberHolder()
	# 		@showPartNumberInput()
	# 		@input_template_item_part_number.focus()
	# 		true
	# 
	# 	handlePartNumberInputBlur: ->
	# 		@hidePartNumberInput()
	# 		@showPartNumberHolder()
	# 		@part_number_holder.html(@input_template_item_part_number.val())
	# 		true
	# 
	# 	hidePartNumberHolder: ->
	# 		@part_number_holder.hide()
	# 
	# 	showPartNumberHolder: ->
	# 		@part_number_holder.show()
	# 
	# 	hidePartNumberInput: ->
	# 		@input_template_item_part_number.hide()
	# 
	# 	showPartNumberInput: ->
	# 		@input_template_item_part_number.show()
	# 
	# 	handleDescriptionHolderClick: ->
	# 		@hideDescriptionHolder()
	# 		@showDescriptionInput()
	# 		@input_template_item_description.focus()
	# 		true
	# 
	# 	handleDescriptionInputBlur: ->
	# 		@hideDescriptionInput()
	# 		@showDescriptionHolder()
	# 		@description_holder.html(@input_template_item_description.val())
	# 		true
	# 
	# 	hideDescriptionHolder: ->
	# 		@description_holder.hide()
	# 
	# 	showDescriptionHolder: ->
	# 		@description_holder.show()
	# 
	# 	hideDescriptionInput: ->
	# 		@input_template_item_description.hide()
	# 
	# 	showDescriptionInput: ->
	# 		@input_template_item_description.show()

	# handleNameInputKeyDown: (e)->
	# 		switch e.keyCode
	# 			when 9
	# 				@handlePartNumberInputBlur()
	# 				@handlePartNumberHolderClick()
	# 				false
	# 			else
	# 				true

	showHidePackageContents: ->
		@input_template_item_hide_package_contents.attr('checked', false)
		@package_contents.removeClass('hide_package_contents')
		@hide_package_contents_container.show()

	hideHidePackageContents: ->
		@input_template_item_hide_package_contents.attr('checked', false)
		@package_contents.removeClass('hide_package_contents')
		@hide_package_contents_container.hide()
	
	handleGroupHeadingClick: ->
		if @input_template_item_is_group_heading.is(':checked')
			@$('li').addClass('template_item_group_heading')
		else
			@$('li').removeClass('template_item_group_heading')
			
	handleHidePackageContentsClick: ->
		if @input_template_item_hide_package_contents.is(':checked')
			@package_contents.addClass('hide_package_contents')
			# @hidePackageContents()
		else
			@package_contents.removeClass('hide_package_contents')
	
	catalogItemSelected: (obj)->
		@catalog_item = new Quota.Models.CatalogItem(obj.catalog_item)
		if obj.catalog_item.pub_key
			@setCatalogItem(@catalog_item)
			@input_template_item_name.val(obj.catalog_item.name)
			# @name_holder.html(obj.catalog_item.name)
			@input_template_item_part_number.val(obj.catalog_item.part_number)
			# @part_number_holder.html(obj.catalog_item.part_number)
			@input_template_item_unit_price.val(obj.catalog_item.list_price)
			# @input_template_item_unit_price_unit.html(obj.catalog_item.recurring_unit)
			@updateTotal()
			@input_template_item_description.val(obj.catalog_item.description)
			# @description_holder.html(obj.catalog_item.description)
			@input_template_item_catalog_item_key.val(obj.catalog_item.pub_key)
		else
			@setCatalogItem(null)
			@input_template_item_name.val(obj.catalog_item.name)
			# @name_holder.html('')
			@input_template_item_part_number.val('')
			# @part_number_holder.html('')
			@input_template_item_unit_price.val(0)
			# @input_template_item_unit_price_unit.html('')
			@input_template_item_total.val(@calcTotal())
			@input_template_item_description.val('')
			# @description_holder.html('')
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
				name: self.input_template_item_name.val()
				part_number: self.input_template_item_part_number.val()
				unit_price: self.input_template_item_unit_price.val()
				quantity: self.input_template_item_quantity.val()
				# unit_price_unit: @input_template_item_unit_price_unit.html()
				is_group_heading: @input_template_item_is_group_heading.is(':checked')
				not_in_total: @input_template_item_not_in_total.is(':checked')
				hide_package_contents: @input_template_item_hide_package_contents.is(':checked')
				total: self.input_template_item_total.val()
				description: self.input_template_item_description.val()
				catalog_item_key: self.input_template_item_catalog_item_key.val()
				template_key: self.parent_model.get("pub_key")
				sort_order: self.model.get("sort_order")
				# sort_order: @template_items.length
			},
			{
				error: ->
					self.hideSpinner()
					# console.log "save error"
				success: (model) -> 
					self.vent.trigger('template_items:save_new_template_item_successful', {model: model})
					self.model = new Quota.Models.TemplateItem() 
					self.render()
					# self.handleNameHolderClick()
					self.vent.trigger('new_templat_item_form:set_sort_order');
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
					console.log "unable to retrieve package contents"
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

	setSortOrder: (so)->
		@model.set({sort_order:so})