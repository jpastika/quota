class Quota.Views.ShowDocument extends Backbone.View

	# template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-document").html()) #JST['quotes/index']
	# 
	el: 'body'
	
	events:
		"focus .document_items_shim" : "handleDocumentItemsShimFocus"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@document_items = options.document_items
		@vent.on('document_items:add_new_item_successful', @addNewItem_Success, @)
		@vent.on('document:save_document', @saveModel, @)
		
		@_itemsView = new Quota.Views.ShowDocumentItems({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@document_items, vent: @vent})
		@_totalsView = new Quota.Views.ShowDocumentItemsTotals({model:@model, parent_child_key: @model.get("pub_key"), collection:@document_items, vent: @vent})
		
	render: ->
		@container_items = @$('#items_container')
		@container_totals = @$('.document-items-totals')
		
		@_itemsView.setElement(@container_items).render()
		@_totalsView.setElement(@container_totals).render()
		@
		
	setup: ->
		@container_items = @$('#items_container')
		@container_totals = @$('.document-items-totals')
		
		@_itemsView.setElement(@container_items).render()
		@_totalsView.setElement(@container_totals).render()
		
	addNewItem_Success: (obj) ->
		self = @
		
	handleDocumentItemsShimFocus: ->
		@vent.trigger('document_items:set_focus', {view: null})
		
	saveModel: ->
		self = @
		# @showSpinner()
		# 		@updateTotal()
		@model.save(
			{
				total_purchase: @model.get("total_purchase")
				total_hourly: @model.get("total_hourly")
				total_daily: @model.get("total_daily")
				total_weekly: @model.get("total_weekly")
				total_monthly: @model.get("total_monthly")
				total_quarterly: @model.get("total_quarterly")
				total_yearly: @model.get("total_yearly")
			},
			{
				error: ->
					# self.hideSpinner()
					# console.log "save error"
				success: (model) -> 
					# self.vent.trigger('document_items:add_new_document_item_successful', {model: model})
					# self.setHolders()
					# 					self.decorateShow()
					# 					self.hideSpinner()
			}
		)
