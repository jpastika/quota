class Quota.Views.ShowTemplateItem2 extends Backbone.View

	template: HandlebarsTemplates['template/show_template_item2'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-remove": "destroy"
		"click .icon-cog": "toggleDetails"
		"change .template_item_quantity": "updateTotal"
		"change .template_item_unit_price": "updateTotal"
		"drop": "dropped"
		"blur input" : "saveModel"
		"change .template_item_name": "checkItemType"
		
		
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
		
		@_catalogItemComboView = new Quota.Views.CatalogItemComboView({parent_model:@model, collection:@catalog_items, source: "name", val: "name", className: 'string required', vent: @vent})
		@_catalogItemComboView.on("catalog_item_combo:item_selected", @addNewItemCatalogItemSelected)
		
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
		
		@details = @$('.template-item-row-details')
		
		
		@_catalogItemComboView.el = @input_template_item_name
		@_catalogItemComboView.render()
		
		if @hideRemove
			@$('.template_item_remove').css('visibility', 'hidden')
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
		
	
	toggleDetails: () ->
		@details.toggle();
		
	dropped: (event, index) ->
		$(@el).trigger('update-sort', [this.model, index]);
	
	addNewItemCatalogItemSelected: (obj)->
		if obj.catalog_item.pub_key
			@input_template_item_name.val(obj.catalog_item.name)
			@input_template_item_part_number.val(obj.catalog_item.part_number)
			@input_template_item_unit_price.val(obj.catalog_item.list_price)
			# @input_template_item_unit_price_unit.html(obj.catalog_item.recurring_unit)
			@updateTotal()
			@input_template_item_description.val(obj.catalog_item.description)
			@input_template_item_catalog_item_key.val(obj.catalog_item.pub_key)
		else
			@input_template_item_name.val(obj.catalog_item.name)
			@input_template_item_part_number.val('')
			@input_template_item_unit_price.val(0)
			# @input_template_item_unit_price_unit.html('')
			@input_template_item_total.val(@calcTotal())
			@input_template_item_description.val('')
			@input_template_item_catalog_item_key.val('')


	calcTotal: ->
		@input_template_item_quantity.val() * @input_template_item_unit_price.val()

	updateTotal: ->
		@input_template_item_total.val(@calcTotal())
		
	saveModel: ->
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
					console.log "save error"
				success: (model) -> 
					self.vent.trigger('template_items:save_template_item_successful', {model: model})
			}
		)
	
	checkItemType: ->
		console.log @model.get("catalog_item_key")