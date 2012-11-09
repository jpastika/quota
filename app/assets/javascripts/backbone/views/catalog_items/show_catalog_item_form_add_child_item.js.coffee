class Quota.Views.ShowCatalogItemFormAddChildItem extends Backbone.View

	template: HandlebarsTemplates['catalog_items/show_catalog_item_form_add_child_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click #catalog_item-add-new-child-item-actions .btn-success": "clickAddNewChildItem"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_child_item:clicked', @showAddChildItem, @)
		@vent.on('done_add_child_item:clicked', @hideAddChildItem, @)
		@vent.on('manufacturers:loaded', @manufacturersLoaded, @)
		@vent.on('catalog_item_child_items:remove_item', @removeCatalogItemChildItem, @)
		@manufacturers = options.manufacturers
		
		@catalog_item = options.parent_model
		@catalog_item_child_items = options.parent_collection
		
		@_manufacturerComboView = new Quota.Views.ManufacturerComboView({parent_model:@model, collection:@manufacturers, el: '#catalog_item_manufacturer', source: "manufacturer", val: "manufacturer", className: 'string input-xlarge', vent: @vent})
		
	render: ->
		$(@el).html(@template({catalog_item:@catalog_item}))
		@manufacturer_name = @$('#catalog_item_manufacturer')
		@input_manufacturer_name = @$('#catalog_item_manufacturer')
		manufacturer_name_field_name = @input_manufacturer_name.attr('name')
		manufacturer_name_field_id = @input_manufacturer_name.attr('id')
		
		@_manufacturerComboView.render()
		
		@input_manufacturer_name = @$('#catalog_item_manufacturer')
		
		@input_manufacturer_name.attr('name', manufacturer_name_field_name)
		@input_manufacturer_name.attr('id', manufacturer_name_field_id)
		
		
		@loading = @$('.section-loading')
		
		@
		
	show: ->
		$(@el).toggle(true)
		
	hide: ->
		$(@el).toggle(false)
		
	showAddChildItem: ->
		@show()
		
	hideAddChildItem: ->
		@hide()
	
	manufacturersReset: ->
		@vent.trigger('manufacturers:loaded')
		@_manufacturerComboView.setElement(@manufacturer_name).render()
		
	showLoading: ->
		@loading.toggle(true)

	hideLoading: ->
		@loading.toggle(false)
	
	manufacturersLoaded: ->
		@hideLoading
		@_manufacturerComboView.setElement(@manufacturer_name).render()
		
		
	clickAddNewChildItem: ->
		self = @
		catalog_item = new Quota.Models.CatalogItem()
		catalog_item.save(
			{
				name: @input_catalog_item_name.val()
				maufacturer_name: @$('#catalog_item_manufacturer_name').val()
			},
			{
				error: ->
					console.log "save error"
				success: (model) -> 
					self.catalog_item_child_items.add(model)
					# self._contactsView.contacts.add(model.get("contact"))
			}
		)
	
	removeCatalogItemChildItem: (item)->
		# @_contactsView.setElement(@container_contacts).render()
		
	resetAddNewChildItemForm: ->
		@input_catalog_item_name.val('')
		@input_catalog_item_manufacturer_name.val('')