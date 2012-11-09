class Quota.Views.ShowCatalogItemChildItemsList extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	el: '#child_items_container .section-table tbody'
	
	# events:
	# 		"click .contact_remove": "destroy"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_childItemViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@catalog_item = options.parent_model
		
		# @vent.on('company_contacts:add_contact', @addCompanyContact, @)
		# 		@vent.on('company_contacts:add_new_contact_successful', @addNewContact_Success, @)
		
		@catalog_items = options.catalog_items
		
	render: ->
		# $(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		@

	addOne: (item)->
		view = new Quota.Views.ShowCatalogItemChildItem({model: item, tagName:'tr', catalog_item: @model, vent: @vent})
		@_childItemViews.push(view)
		view

	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_childItemViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
		# console.log "got here"

	# destroy: (evt) ->
	# 		$(@el).toggle()
	# 		# @model.trigger('removing', {view: @})
	# 		@model.remove()

	hideRemove: () ->
		@hideRemove = true
		@$el.find('.child_item_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		@$el.find('.child_item_remove').css('visibility', '')
		
	# addCompanyContact: (obj)->
	# 		self = @
	# 		contact = new Quota.Models.OpportunityContact()
	# 		contact.save(
	# 			{
	# 				opportunity_key: @opportunity.get("pub_key")
	# 				contact_key: obj.contact.get("pub_key")
	# 				account_key: @opportunity.get("account_key")
	# 			},
	# 			{
	# 				error:  ()-> 
	# 					@vent.trigger("company_contacts:add_contact_failed", {pub_key:obj.contact.get("pub_key")})
	# 					@handleError
	# 				success: (model) -> 
	# 					self.addCompanyContact_Success(model)
	# 				# silent: true
	# 			}
	# 		)

	addNewCatalogItem_Success: (obj)->
		@addCatalogItem_Success(obj.model)

	addCatalogItem_Success: (model)->
		self = @
		
		# if model.get("catalog_item").parent_key and @companies.where(pub_key: model.get("contact").company_key).length == 0
		# 			@companies.add(model.get("contact").company)
		
		self.catalog_item.get("catalog_item_child_items").add(model)
		frag = document.createDocumentFragment()
		frag.appendChild(self.addOne(model).render().el)
		self.$el.append(frag)
		

	handleError: (attribute, message) ->
		console.log message