class Quota.Views.ShowTemplateItem extends Backbone.View

	template: HandlebarsTemplates['template/show_template_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-sort-down": "togglePackageContents"
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
		"keydown .template_item_name": "handleNameInputKeyDown"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@item = options.item
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.on('destroy', @remove, @)
		# @model.on('change', @modelChanged, @)
		@parent_model = options.parent_model
		@catalog_items = options.catalog_items
		
		if @model.get("catalog_item_key")
			@setCatalogItem(@getCatalogItem(@model.get("catalog_item_key")))
			
		@_catalogItemComboView = new Quota.Views.CatalogItemComboView({parent_model:@model, collection:@catalog_items, source: "name", val: "name", className: 'string required', vent: @vent})
		@_catalogItemComboView.on("catalog_item_combo:item_selected", @catalogItemSelected)
		
		# @vent.on('catalog_item_combo:item_selected', @addNewItemCatalogItemSelected, @)
		

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
		
		@name_holder = @$('.template_item_name_holder')
		@part_number_holder = @$('.template_item_part_number_holder')
		
		@details = @$('.template-item-row-details')
		@details_toggle = @$('.icon-cog')
		@package_toggle = @$('.icon-sort-down')
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
		
	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.template_item_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		$(@el).find('.template_item_remove').css('visibility', '')
		
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
		@package_toggle.hide()

	showPackageToggle: () ->
		@package_toggle.show()

	togglePackageToggle: () ->
		@package_toggle.toggle()

	toggleDetails: () ->
		@details.toggle()
		
	togglePackageContents: () ->
		@package_contents.toggle()
		
	handleNameHolderClick: ->
		@hideNameHolder()
		@showNameInput()
		@input_template_item_name.focus()
		true
		
	handleNameInputBlur: ->
		@hideNameInput()
		@showNameHolder()
		@name_holder.html(@input_template_item_name.val())
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
		true

	handlePartNumberInputBlur: ->
		@hidePartNumberInput()
		@showPartNumberHolder()
		@part_number_holder.html(@input_template_item_part_number.val())
		true

	hidePartNumberHolder: ->
		@part_number_holder.hide()

	showPartNumberHolder: ->
		@part_number_holder.show()

	hidePartNumberInput: ->
		@input_template_item_part_number.hide()

	showPartNumberInput: ->
		@input_template_item_part_number.show()
		
	handleNameInputKeyDown: (e)->
		switch e.keyCode
			when 9
				@handlePartNumberInputBlur()
				@handlePartNumberHolderClick()
				false
			else
				true
		
	dropped: (event, index) ->
		$(@el).trigger('update-sort', [this.model, index])
	
	catalogItemSelected: (obj)->
		catalog_item = new Quota.Models.CatalogItem(obj.catalog_item)
		if obj.catalog_item.pub_key
			@setCatalogItem(catalog_item)
			@input_template_item_name.val(obj.catalog_item.name)
			@name_holder.html(obj.catalog_item.name)
			@input_template_item_part_number.val(obj.catalog_item.part_number)
			@part_number_holder.html(obj.catalog_item.part_number)
			@input_template_item_unit_price.val(obj.catalog_item.list_price)
			# @input_template_item_unit_price_unit.html(obj.catalog_item.recurring_unit)
			@updateTotal()
			@input_template_item_description.val(obj.catalog_item.description)
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
		
	getCatalogItem: (catalog_item_key)->
		self = @
		
		catalog_item = _.find(self.catalog_items.models, 
			(model)-> 
				model.get("pub_key") == self.model.get("catalog_item_key")
		)
		
		catalog_item
		
	
	handleItemType: ->
		if @catalog_item && @catalog_item.get("is_package") == true
			@showPackageToggle()
		else
			@hidePackageToggle()