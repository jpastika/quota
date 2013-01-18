class Quota.Views.ShowTemplateItemsList2 extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	el: '#items_container2 .section-table-rows ul'
	
	events:
		"update-sort": "updateSort"

	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_itemViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@template_model = options.parent_model
		@catalog_items = options.catalog_items
		
			
		# @vent.on('company_contacts:add_contact', @addCompanyContact, @)
		# 		@vent.on('company_contacts:add_new_contact_successful', @addNewContact_Success, @)
		
		# @template_items = options.template_items
		# @vent.on('catalog_search_results:add_item', @addCatalogSearchItem, @)
		
	render: ->
		# $(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		
		@$el.sortable({
			axis: "y"
			, items: "li"
			, handle: ".icon-sort"
			, stop: @sortStop
			, placeholder: "ui-state-highlight"
		});
		@

	addOne: (item)->
		if item.get("is_package")
			view = new Quota.Views.ShowTemplateItem2_Package({model: item, tagName:'li', template_item: @model, catalog_items: @catalog_items, parent_model: @template_model, vent: @vent})
		else
			view = new Quota.Views.ShowTemplateItem2({model: item, tagName:'li', template_item: @model, catalog_items: @catalog_items, parent_model: @template_model, vent: @vent})
		@_itemViews.push(view)
		view

	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_itemViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
		# console.log "got here"

	sortStop: (event, ui) ->
		ui.item.trigger('drop', ui.item.index());

	hideRemove: () ->
		@hideRemove = true
		@$el.find('.template_item_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		@$el.find('.template_item_remove').css('visibility', '')
		
	updateSort: (event, model, position) ->           
		@collection.remove(model)

		@collection.each(
			(model, index) ->
			   	ordinal = index
			   	if (index >= position)
			       	ordinal += 1
			   	model.set('sort_order', ordinal)
		)           

		model.set('sort_order', position)
		@collection.add(model, {at: position})

		# to update ordinals on server:
		ids = @collection.pluck('id')
		sos = @collection.pluck('sort_order')
		# $('#post-data').html('post ids to server: ' + ids.join(', '));
		console.log ids
		console.log sos

		# @render()
		
	addNewTemplateItem_Success: (model)->
		@addTemplateItem_Success(model)

	addTemplateItem_Success: (model)->
		self = @
		
		# if model.get("catalog_item").parent_key and @companies.where(pub_key: model.get("contact").company_key).length == 0
		# 			@companies.add(model.get("contact").company)
		
		self.template_model.get("template_items").add(model)
		frag = document.createDocumentFragment()
		frag.appendChild(self.addOne(model).render().el)
		self.$el.append(frag)
		

	handleError: (attribute, message) ->
		# console.log message