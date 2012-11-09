class Quota.Views.ShowCatalogItemChildItems extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: '#child_items_container .section-table'
	
	events:
		"click #catalog-item-child-items-actions>.btn-primary": "addItemClicked"
		"click #catalog-item-child-items-actions>.btn-danger": "doneAddItemClicked"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@collection = options.collection
		@catalog_item = options.parent_model
		@manufacturers = options.manufacturers
		@parent_child_key = options.parent_child_key
		
		@_addItemView = new Quota.Views.ShowCatalogItemFormAddChildItem({model: new Quota.Models.CatalogItem(), parent_model:@catalog_item, parent_child_key: @catalog_item.get("pub_key"), vent: @vent, parent_collection: @collection, manufacturers: @manufacturers})
		
		@_childItemsListView = new Quota.Views.ShowCatalogItemChildItemsList({model: new Quota.Models.CatalogItem(), parent_model:@catalog_item, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@vent.on('company_contacts:add_contact', @addCompanyContact, @)
		@vent.on('company_contacts:add_new_contact_successful', @addNewContact_Success, @)
		@vent.on('catalog_item_child_items:remove_item', @removeCatalogItemChildItem, @)
		
		
		
	render: ->
		# $(@el).html(@template({}))
		@container_child_item_list = @$('.section-table tbody')
		@_childItemsListView.setElement(@container_child_item_list).render()
		# @_contactsListView.setElement(@container_contact_list).render().hide()
		# @_addContactView.companies.fetch()
		# frag = document.createDocumentFragment()
		# 		frag.appendChild(@_contactsListView.render().el)
		# 		@$('.section-table').append(frag)
		# 		
		@container_add_child_item = @$('.section-form')
		@_addItemView.setElement(@container_add_child_item).render()
		# @_addContactView.companies.fetch()
		
		# @hideDoneLink()
		
		@
	
	# companyAdded: ->
	# 		@_addContactView.setElement(@container_add_contact).render()
	# 	
	addItemClicked: ->
		@vent.trigger('add_child_item:clicked')
		@_addItemView.resetAddNewChildItemForm()
		@hideAddBtn()
		@showDoneLink()
		@showAddForm()
		

	doneAddItemClicked: ->
		@vent.trigger('done_add_child_item:clicked')
		@_addItemView.resetAddNewChildItemForm()
		@hideDoneLink()
		@showAddBtn()
		@hideAddForm()
		
	removeCatalogItemChildItem: (item)->
		@collection.remove(item)

	hideAddBtn: ->
		@$('#catalog-item-child-items-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#catalog-item-child-items-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#catalog-item-child-items-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#catalog-item-child-items-actions>.btn-danger').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)