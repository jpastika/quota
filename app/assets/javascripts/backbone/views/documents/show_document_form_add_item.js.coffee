class Quota.Views.ShowDocumentFormAddItem extends Backbone.View

	template: HandlebarsTemplates['documents/show_document_form_add_item'] #Handlebars.compile($("#quote-document").html()) #JST['quotes/index']
	
	events:
		"click .icon-sort-down": "showPackageContents"
		"click .icon-sort-up": "hidePackageContents"
		"click .icon-cog": "toggleDetails"
		"click .icon-ok": "saveModel"
		"change .document_item_quantity": "updateTotal"
		"change .document_item_unit_price": "updateTotal"
		"change .document_item_unit_price_unit": "setTotalUnit"
		# "change .document_item_total_unit": "setTotalUnitHolder"
		# "click .document_item_name_holder": "handleNameHolderClick"
		# "blur .document_item_name": "handleNameInputBlur"
		# "click .document_item_part_number_holder": "handlePartNumberHolderClick"
		# "blur .document_item_part_number": "handlePartNumberInputBlur"
		# "click .document_item_description_holder": "handleDescriptionHolderClick"
		# "blur .document_item_description": "handleDescriptionInputBlur"
		# "keydown .document_item_name": "handleNameInputKeyDown"
		"focus input" : "handleFocus"
		"click .document_item_is_group_heading": "handleGroupHeadingClick"
		"click .document_item_hide_package_contents": "handleHidePackageContentsClick"
			
	initialize: (options)->
		self = @
		_.bindAll(@)
		@item = options.item
		@vent = options.vent
		@parent_model = options.parent_model
		
		@_catalogItemComboView = new Quota.Views.CatalogItemComboView({parent_model:@model, source: "name", val: "name", className: 'string required', vent: @vent})
		@_catalogItemComboView.on("catalog_item_combo:item_selected", @catalogItemSelected)
		

	render: ->
		$(@el).html(@template({document_item:@model.toJSON()}))
		
		@input_document_item_name = @$('.document_item_name')
		@input_document_item_part_number = @$('.document_item_part_number')
		@input_document_item_quantity = @$('.document_item_quantity')
		@input_document_item_unit_price = @$('.document_item_unit_price')
		@input_document_item_unit_price_unit = @$('.document_item_unit_price_unit')
		@input_document_item_total = @$('.document_item_total')
		@input_document_item_total_unit = @$('.document_item_total_unit')
		@input_document_item_description = @$('.document_item_description')
		@input_document_item_is_group_heading = @$('.document_item_is_group_heading')
		@input_document_item_not_in_total = @$('.document_item_not_in_total')
		@input_document_item_hide_package_contents = @$('.document_item_hide_package_contents')
		@input_document_item_catalog_item_key = @$('.document_item_catalog_item_key')
		
		@total_unit_holder = @$('.document_item_total_unit_holder')
		
		@details = @$('.document-item-row-details')
		@details_toggle = @$('.icon-cog')
		@package_toggle_down = @$('.icon-sort-down')
		@package_toggle_up = @$('.icon-sort-up')
		@package_contents = @$('.document-item-row-package-contents')
		@package_contents_list = @$('.document-item-row-package-contents td ul')
		@spinner = @$('.icon-spinner')
		@hide_package_contents_container = @$('.document_item_hide_package_contents_container')
		
		@_catalogItemComboView.el = @input_document_item_name
		@_catalogItemComboView.render()
		
		@
		
	handleFocus: ->
		@vent.trigger('document_items:set_focus', {view: null})
		
	setTotalUnit: ->
		@input_document_item_total_unit.val(@input_document_item_unit_price_unit.val())

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

	showHidePackageContents: ->
		@input_document_item_hide_package_contents.attr('checked', false)
		@package_contents.removeClass('hide_package_contents')
		@hide_package_contents_container.show()

	hideHidePackageContents: ->
		@input_document_item_hide_package_contents.attr('checked', false)
		@package_contents.removeClass('hide_package_contents')
		@hide_package_contents_container.hide()
	
	handleGroupHeadingClick: ->
		if @input_document_item_is_group_heading.is(':checked')
			@$('li').addClass('document_item_group_heading')
		else
			@$('li').removeClass('document_item_group_heading')
			
	handleHidePackageContentsClick: ->
		if @input_document_item_hide_package_contents.is(':checked')
			@package_contents.addClass('hide_package_contents')
			# @hidePackageContents()
		else
			@package_contents.removeClass('hide_package_contents')
	
	catalogItemSelected: (obj)->
		@catalog_item = new Quota.Models.CatalogItem(obj.catalog_item)
		if obj.catalog_item.pub_key
			@setCatalogItem(@catalog_item)
			@input_document_item_name.val(obj.catalog_item.name)
			# @name_holder.html(obj.catalog_item.name)
			@input_document_item_part_number.val(obj.catalog_item.part_number)
			# @part_number_holder.html(obj.catalog_item.part_number)
			@input_document_item_unit_price.val(obj.catalog_item.list_price)
			@input_document_item_unit_price_unit.val(obj.catalog_item.recurring_unit)
			@updateTotal()
			@input_document_item_total_unit.val(obj.catalog_item.recurring_unit)
			# @total_unit_holder.html(obj.catalog_item.recurring_unit)
			@input_document_item_description.val(obj.catalog_item.description)
			# @description_holder.html(obj.catalog_item.description)
			@input_document_item_catalog_item_key.val(obj.catalog_item.pub_key)
		else
			@setCatalogItem(null)
			@input_document_item_name.val(obj.catalog_item.name)
			# @name_holder.html('')
			@input_document_item_part_number.val('')
			# @part_number_holder.html('')
			@input_document_item_unit_price.val(0)
			@input_document_item_unit_price_unit.val('')
			@input_document_item_total.val(@calcTotal())
			@input_document_item_total_unit.val('')
			# @total_unit_holder.html('')
			@input_document_item_description.val('')
			# @description_holder.html('')
			@input_document_item_catalog_item_key.val('')
			
		@handleItemType()


	calcTotal: ->
		@input_document_item_quantity.val(@input_document_item_quantity.val().replace(/[^\d.-]/g, ''))
		@input_document_item_unit_price.val(@input_document_item_unit_price.val().replace(/[^\d.-]/g, ''))
		@input_document_item_quantity.val() * @input_document_item_unit_price.val()

	updateTotal: ->
		@input_document_item_total.val(@calcTotal())
		
	saveModel: ->
		self = @
		@showSpinner()
		@model.save(
			{
				name: self.input_document_item_name.val()
				part_number: self.input_document_item_part_number.val()
				unit_price: self.input_document_item_unit_price.val()
				quantity: self.input_document_item_quantity.val()
				unit_price_unit: self.input_document_item_unit_price_unit.val()
				is_group_heading: self.input_document_item_is_group_heading.is(':checked')
				not_in_total: self.input_document_item_not_in_total.is(':checked')
				hide_package_contents: self.input_document_item_hide_package_contents.is(':checked')
				total: self.input_document_item_total.val()
				total_unit: self.input_document_item_total_unit.val()
				description: self.input_document_item_description.val()
				catalog_item_key: self.input_document_item_catalog_item_key.val()
				document_key: self.parent_model.get("pub_key")
				sort_order: self.model.get("sort_order")
				# sort_order: @document_items.length
			},
			{
				error: ->
					self.hideSpinner()
					# console.log "save error"
				success: (model) -> 
					self.vent.trigger('document_items:save_new_document_item_successful', {model: model})
					self.model = new Quota.Models.DocumentItem() 
					self.render()
					self.input_document_item_name.focus()
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