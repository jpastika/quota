class Quota.Views.CatalogItemSearchList extends Backbone.View

	template: HandlebarsTemplates['catalog_items/catalog_item_seach_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	# events:
	# 		"change select": "companyChanged"

	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@parent_child_key = options.parent_child_key
		@_itemViews = []
		# @vent.on('company:changed', @companyChanged, @)
		@vent.on('item:add_item', @addItem, @)
		@vent.on("item:add_item_failed", @addItem_failed, @)
		# @vent.on('add_contact', @addCompanyContact, @)
		@collection.on('reset', @itemsReset, @)
		
	render: ->
		$(@el).html(@template({}))
		@appendOne(@addOne(item)) for item in @collection.models

		@

	itemsReset: ->
		@render()

	addOne: (item)->
		view = new Quota.Views.CatalogItemSearchAdd({model: item, vent: @vent})
		@_itemViews.push(view)
		# view
		frag = document.createDocumentFragment()
		frag.appendChild(view.render().el)
		frag

	appendOne: (frag)->
		@$('#search_results').append(frag)

	addItem: (obj)->
		# view = _.find(@_contactViews, (view) -> view.model == obj.contact).remove()
		# 		if view
		# 			view.remove()
		# 		@contacts.url='/api/companies/'+ @parent_model.get("pub_key") + '/contacts'
		# 		@contacts.fetch()
		# view = _.find(@_contactViews, (view) -> view.model == obj.contact).remove()
		# 	# console.log view
		# 	# 		view.remove()
		# 	if @$('#company_contacts div').length == 0
		# 		@$('#company_contacts').html('All contacts from '+ @parent_model.get("name") + ' have been added to opportunity.')
		# # 		console.log obj.contact.get("name")

	addItem_failed: (obj)->
		# @appendOne(@addOne(item)) for item in @contacts.models when @selected_contacts.where({contact_key: item.get("pub_key")}).length == 0
		# console.log @contacts
		# 		console.log @contacts.where({pub_key: obj.pub_key})[0]
		# if obj.pub_key == @parent_model.get("pub_key")
		# 			@appendOne(@addOne(@parent_model))
		# 		else
		# 			@appendOne(@addOne(@collection.where({pub_key: obj.pub_key})[0]))
