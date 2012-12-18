class Quota.Views.ShowTemplateProducts extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: '#products_container .section-table'
	
	events:
		"click #template-products-actions>.btn-primary": "addItemClicked"
		"click #template-products-actions>.btn-danger": "doneAddItemClicked"
		"click #template-products-actions>.btn-success": "addNewItemClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@collection = options.collection
		@template_model = options.parent_model
		# @manufacturers = options.manufacturers
		@parent_child_key = options.parent_child_key
		@catalog_items = options.catalog_items
		
		@_addItemView = new Quota.Views.ShowTemplateFormAddProduct({model: new Quota.Models.CatalogItem(), parent_model:@template_model, parent_child_key: @template_model.get("pub_key"), vent: @vent, parent_collection: @collection, catalog_items: @catalog_items})
		
		@_templateItemsListView = new Quota.Views.ShowTemplateProductsList({model: new Quota.Models.TemplateItem(), parent_model:@template_model, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@vent.on('template_products:add_new_product_child_successful', @addNewProduct_Success, @)
		@vent.on('template_products:remove_item', @removeTemplateProduct, @)
		
		
		
	render: ->
		# $(@el).html(@template({}))
		@container_product_list = @$('.section-table tbody')
		@_templateItemsListView.setElement(@container_product_list).render()
		# @_contactsListView.setElement(@container_contact_list).render().hide()
		# @_addContactView.companies.fetch()
		# frag = document.createDocumentFragment()
		# 		frag.appendChild(@_contactsListView.render().el)
		# 		@$('.section-table').append(frag)
		# 		
		@container_add_product = @$('.section-form')
		@_addItemView.setElement(@container_add_product).render()
		# @_addContactView.companies.fetch()
		
		# @hideDoneLink()
		
		@
	
	addNewProduct_Success: (obj)->
		@_childItemsListView.addNewCatalogItem_Success(obj.model)
		
	addItemClicked: ->
		@vent.trigger('add_product:clicked')
		@_addItemView.resetAddNewProductForm()
		@hideAddBtn()
		@showAddItem()
		@showDoneLink()
		@showAddForm()
		

	doneAddItemClicked: ->
		@vent.trigger('done_add_child_item:clicked')
		@_addItemView.resetAddNewProductForm()
		@hideDoneLink()
		@hideAddItem()
		@showAddBtn()
		@hideAddForm()
		
	removeTemplateProduct: (item)->
		@collection.remove(item)
		
	addNewItemClicked: ->
		@vent.trigger('template_products:add_new_template_item', {model: @model})
		
		
	hideAddBtn: ->
		@$('#template-products-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#template-products-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#template-products-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#template-products-actions>.btn-danger').toggle(true)
	
	hideAddItem: ->
		@$('#template-products-actions>.btn-success').toggle(false)

	showAddItem: ->
		@$('#template-products-actions>.btn-success').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)