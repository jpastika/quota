class Quota.Views.ShowDocumentItems extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-document").html()) #JST['quotes/index']
	el: '#items_container .section-table-rows'
	
	# events:
	# 		"click #document-items-actions>.btn-primary": "addItemClicked"
	# 		"click #document-items-actions>.btn-danger": "doneAddItemClicked"
	# 		"click #document-items-actions>.btn-success": "addNewItemClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@collection = options.collection
		@document_model = options.parent_model
		# @manufacturers = options.manufacturers
		@parent_child_key = options.parent_child_key
		
		@_addItemView = new Quota.Views.ShowDocumentFormAddItem({model: new Quota.Models.DocumentItem(), parent_model:@document_model, parent_child_key: @document_model.get("pub_key"), vent: @vent, parent_collection: @collection, tagName:'li'})
		
		@_documentItemsListView = new Quota.Views.ShowDocumentItemsList({model: new Quota.Models.DocumentItem(), parent_model:@document_model, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@_totalsView = new Quota.Views.ShowDocumentItemsTotals({model: new Quota.Models.DocumentItem(), parent_model:@document_model, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@newDocumentItemForm_SetSortOrder()
		
		@vent.on('document_items:save_new_document_item_successful', @addNewItem_Success, @)
		@vent.on('document_items:remove_document_item', @removeDocumentItem, @)
		@vent.on('document_items:save_document_item_successful', @saveDocumentItem_Success, @)
		@vent.on('new_templat_item_form:set_sort_order', @newDocumentItemForm_SetSortOrder, @)
		
	render: ->
		# $(@el).html(@document({}))
		@container_item_list = @$('.document-items-rows ul')
		@_documentItemsListView.setElement(@container_item_list).render()
		@container_add_item = @$('.document-items-new ul')
		@_addItemView.setElement(@container_add_item).render()
		@
		
	newDocumentItemForm_SetSortOrder: ->
		@_addItemView.setSortOrder(@collection.length)
	
	addNewItem_Success: (obj)->
		@_documentItemsListView.addNewDocumentItem_Success(obj.model)
		
	saveDocumentItem_Success: (obj)->
		# console.log "saved"
		
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
		
	removeDocumentItem: (item)->
		@collection.remove(item)
		@_documentItemsListView.setSortOrder()
		@_addItemView.setSortOrder(@collection.length)
		@vent.trigger('document_items:set_totals')
		
		
	addNewItemClicked: ->
		@vent.trigger('document_items:add_new_document_item', {model: @model})
		
		
	hideAddBtn: ->
		@$('#document-items-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#document-items-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#document-items-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#document-items-actions>.btn-danger').toggle(true)
	
	hideAddItem: ->
		@$('#document-items-actions>.btn-success').toggle(false)

	showAddItem: ->
		@$('#document-items-actions>.btn-success').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)