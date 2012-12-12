class Quota.Views.ShowTemplateProductsList extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	el: '#products_container .section-table tbody'
	
	# events:
	# 		"click .contact_remove": "destroy"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_productViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@template_model = options.parent_model
			
		# @vent.on('company_contacts:add_contact', @addCompanyContact, @)
		# 		@vent.on('company_contacts:add_new_contact_successful', @addNewContact_Success, @)
		
		# @template_items = options.template_items
		# @vent.on('catalog_search_results:add_item', @addCatalogSearchItem, @)
		
	render: ->
		# $(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		@

	addOne: (item)->
		view = new Quota.Views.ShowTemplateProduct({model: item, tagName:'tr', template_item: @model, vent: @vent})
		@_productViews.push(view)
		view

	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_productViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
		# console.log "got here"

	# destroy: (evt) ->
	# 		$(@el).toggle()
	# 		# @model.trigger('removing', {view: @})
	# 		@model.remove()

	hideRemove: () ->
		@hideRemove = true
		@$el.find('.template_item_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		@$el.find('.template_item_remove').css('visibility', '')
		
	# addCatalogSearchItem: (obj)->
	# 		self = @
	# 		# obj.save(
	# 		# 			{
	# 		# 				parent_key: @catalog_item.get("pub_key")
	# 		# 			},
	# 		# 			{
	# 		# 				error:  ()-> 
	# 		# 					# @vent.trigger("child_items:add_item_failed", {pub_key:obj.get("pub_key")})
	# 		# 					@handleError
	# 		# 				success: (model) -> 
	# 		# 					self.addCatalogItem_Success(model)
	# 		# 				# silent: true
	# 		# 			}
	# 		# 		)
	# 		# 		
	# 		item = new Quota.Models.CatalogItemChild()
	# 		item.save(
	# 			{
	# 				parent_key: @catalog_item.get("pub_key")
	# 				child_key: obj.catalog_item.get("pub_key")
	# 				account_key: @catalog_item.get("account_key")
	# 			},
	# 			{
	# 				error:  ()-> 
	# 					# @vent.trigger("child_items:add_item_failed", {pub_key:obj.get("pub_key")})
	# 					@handleError
	# 				success: (model) -> 
	# 					self.addCatalogItem_Success(model)
	# 				# silent: true
	# 			}
	# 		)
		

	addNewProduct_Success: (model)->
		@addProduct_Success(model)

	addProduct_Success: (model)->
		self = @
		
		# if model.get("catalog_item").parent_key and @companies.where(pub_key: model.get("contact").company_key).length == 0
		# 			@companies.add(model.get("contact").company)
		
		self.template_model.get("template_items").add(model)
		frag = document.createDocumentFragment()
		frag.appendChild(self.addOne(model).render().el)
		self.$el.append(frag)
		

	handleError: (attribute, message) ->
		# console.log message