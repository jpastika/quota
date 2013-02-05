class Quota.Views.ShowTemplate extends Quota.Views.PageBodyBlock

	# template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# 
	el: 'body'
	
	events:
		"focus .template_items_shim" : "handleTemplateItemsShimFocus"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@template_items = options.template_items
		@vent.on('template_items:add_new_item_successful', @addNewItem_Success, @)
		@vent.on('template:save_template', @saveModel, @)
		
		@_itemsView = new Quota.Views.ShowTemplateItems({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@template_items, vent: @vent})
		@_totalsView = new Quota.Views.ShowTemplateItemsTotals({model:@model, parent_child_key: @model.get("pub_key"), collection:@template_items, vent: @vent})
		
	render: ->
		@container_items = @$('#items_container')
		@container_totals = @$('.template-items-totals')
		
		@_itemsView.setElement(@container_items).render()
		@_totalsView.setElement(@container_totals).render()
		@
		
	setup: ->
		@container_items = @$('#items_container')
		@container_totals = @$('.template-items-totals')
		
		@_itemsView.setElement(@container_items).render()
		@_totalsView.setElement(@container_totals).render()
		
	addNewItem_Success: (obj) ->
		self = @
		
	handleTemplateItemsShimFocus: ->
		@vent.trigger('template_items:set_focus', {view: null})
		
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
					# self.vent.trigger('template_items:add_new_template_item_successful', {model: model})
					# self.setHolders()
					# 					self.decorateShow()
					# 					self.hideSpinner()
			}
		)
		