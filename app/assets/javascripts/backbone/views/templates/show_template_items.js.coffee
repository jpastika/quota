class Quota.Views.ShowTemplateItems extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: '#items_container .section-table'
	
	events:
		"click #template-items-actions>.btn-primary": "addItemClicked"
		"click #template-items-actions>.btn-danger": "doneAddItemClicked"
		"click #template-items-actions>.btn-success": "addNewItemClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@collection = options.collection
		@template_model = options.parent_model
		# @manufacturers = options.manufacturers
		@parent_child_key = options.parent_child_key
		@catalog_items = options.catalog_items
		
		@_addItemView = new Quota.Views.ShowTemplateFormAddItem({model: new Quota.Models.TemplateItem(), parent_model:@template_model, parent_child_key: @template_model.get("pub_key"), vent: @vent, parent_collection: @collection, catalog_items: @catalog_items})
		
		@_templateItemsListView = new Quota.Views.ShowTemplateItemsList({model: new Quota.Models.TemplateItem(), parent_model:@template_model, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@vent.on('template_items:add_new_template_item_successful', @addNewItem_Success, @)
		@vent.on('template_items:remove_item', @removeTemplateItem, @)
		
		
		
	render: ->
		# $(@el).html(@template({}))
		@container_item_list = @$('.section-table tbody')
		@_templateItemsListView.setElement(@container_item_list).render()
		# @_contactsListView.setElement(@container_contact_list).render().hide()
		# @_addContactView.companies.fetch()
		# frag = document.createDocumentFragment()
		# 		frag.appendChild(@_contactsListView.render().el)
		# 		@$('.section-table').append(frag)
		# 		
		@container_add_item = @$('.section-form')
		@_addItemView.setElement(@container_add_item).render()
		# @_addContactView.companies.fetch()
		
		# @hideDoneLink()
		
		@
	
	addNewItem_Success: (obj)->
		@_templateItemsListView.addNewTemplateItem_Success(obj.model)
		
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