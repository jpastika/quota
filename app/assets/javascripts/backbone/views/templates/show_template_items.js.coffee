class Quota.Views.ShowTemplateItems extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: '#items_container .section-table-rows'
	
	# events:
	# 		"click #template-items-actions>.btn-primary": "addItemClicked"
	# 		"click #template-items-actions>.btn-danger": "doneAddItemClicked"
	# 		"click #template-items-actions>.btn-success": "addNewItemClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@collection = options.collection
		@template_model = options.parent_model
		# @manufacturers = options.manufacturers
		@parent_child_key = options.parent_child_key
		
		@_addItemView = new Quota.Views.ShowTemplateFormAddItem({model: new Quota.Models.TemplateItem(), parent_model:@template_model, parent_child_key: @template_model.get("pub_key"), vent: @vent, parent_collection: @collection, tagName:'li'})
		
		@_templateItemsListView = new Quota.Views.ShowTemplateItemsList({model: new Quota.Models.TemplateItem(), parent_model:@template_model, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@_totalsView = new Quota.Views.ShowTemplateItemsTotals({model: new Quota.Models.TemplateItem(), parent_model:@template_model, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@newTemplateItemForm_SetSortOrder()
		
		@vent.on('template_items:save_new_template_item_successful', @addNewItem_Success, @)
		@vent.on('template_items:remove_template_item', @removeTemplateItem, @)
		@vent.on('template_items:save_template_item_successful', @saveTemplateItem_Success, @)
		@vent.on('new_templat_item_form:set_sort_order', @newTemplateItemForm_SetSortOrder, @)
		
	render: ->
		# $(@el).html(@template({}))
		@container_item_list = @$('.template-items-rows ul')
		@_templateItemsListView.setElement(@container_item_list).render()
		@container_add_item = @$('.template-items-new ul')
		@_addItemView.setElement(@container_add_item).render()
		@
		
	newTemplateItemForm_SetSortOrder: ->
		@_addItemView.setSortOrder(@collection.length)
	
	addNewItem_Success: (obj)->
		@_templateItemsListView.addNewTemplateItem_Success(obj.model)
		
	saveTemplateItem_Success: (obj)->
		console.log "saved"
		
	addItemClicked: ->
		@vent.trigger('add_item:clicked')
		@_addItemView.resetAddNewItemForm()
		@hideAddBtn()
		@showAddItem()
		@showDoneLink()
		@showAddForm()
		

	doneAddItemClicked: ->
		@vent.trigger('done_add_item:clicked')
		@_addItemView.resetAddNewItemForm()
		@hideDoneLink()
		@hideAddItem()
		@showAddBtn()
		@hideAddForm()
		
	removeTemplateItem: (item)->
		@collection.remove(item)
		@_templateItemsListView.setSortOrder()
		@_addItemView.setSortOrder(@collection.length)
		
	addNewItemClicked: ->
		@vent.trigger('template_items:add_new_template_item', {model: @model})
		
		
	hideAddBtn: ->
		@$('#template-items-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#template-items-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#template-items-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#template-items-actions>.btn-danger').toggle(true)
	
	hideAddItem: ->
		@$('#template-items-actions>.btn-success').toggle(false)

	showAddItem: ->
		@$('#template-items-actions>.btn-success').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)