class Quota.Views.ShowDocumentItemsTotals extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-document").html()) #JST['quotes/index']
	
	el: '.document-items-totals'
	
	# events:
	# 		"update-sort": "updateOrder"
	
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		# @model.on('change', @saveModel, @)
		# @collection.on('change', @render, @)
		
	render: ->
		# $(@el).html(@document({}))
		@total_purchase = @$('.document_total_purchase')
		@total_hourly = @$('.document_total_hourly')
		@total_daily = @$('.document_total_daily')
		@total_weekly = @$('.document_total_weekly')
		@total_monthly = @$('.document_total_monthly')
		@total_quarterly = @$('.document_total_quarterly')
		@total_yearly = @$('.document_total_yearly')
		
		@total_purchase_holder = @$('.document_total_purchase_holder')
		@total_hourly_holder = @$('.document_total_hourly_holder')
		@total_daily_holder = @$('.document_total_daily_holder')
		@total_weekly_holder = @$('.document_total_weekly_holder')
		@total_monthly_holder = @$('.document_total_monthly_holder')
		@total_quarterly_holder = @$('.document_total_quarterly_holder')
		@total_yearly_holder = @$('.document_total_yearly_holder')
		
		@setTotals()
		# @total_purchase.show()
		# 		@total_hourly.show()
		# 		@total_daily.show()
		# 		@total_weekly.show()
		# 		@total_monthly.show()
		# 		@total_quarterly.show()
		# 		@total_yearly.show()
		
		@vent.on('document_items:set_totals', @setTotals)
		@
		
	setTotals: ->
		@setTotalPurchase()
		@setTotalHourly()
		@setTotalDaily()
		@setTotalWeekly()
		@setTotalMonthly()
		@setTotalQuarterly()
		@setTotalYearly()
		
		if @model.changed
			@vent.trigger('document:save_document')
		true
		
	setTotalPurchase: ->
		tot = @calcTotal("")
		@model.set("total_purchase", tot)
		@total_purchase_holder.html(accounting.formatMoney(tot, "$ "))
		# if tot > 0
		@total_purchase.show()
		# else
		# 			@total_purchase.hide()
		true
	
	setTotalHourly: ->
		tot = @calcTotal("per hour")
		@model.set("total_hourly", tot)
		@total_hourly_holder.html(accounting.formatMoney(tot, "$ "))
		# if tot > 0
		@total_hourly.show()
		# else
		# 			@total_hourly.hide()
		true

	setTotalDaily: ->
		tot = @calcTotal("per day")
		@model.set("total_daily", tot)
		@total_daily_holder.html(accounting.formatMoney(tot, "$ "))
		# if tot > 0
		@total_daily.show()
		# else
		# 			@total_daily.hide()
		true

	setTotalWeekly: ->
		tot = @calcTotal("per week")
		@model.set("total_weekly", tot)
		@total_weekly_holder.html(accounting.formatMoney(tot, "$ "))
		# if tot > 0
		@total_weekly.show()
		# else
		# 			@total_weekly.hide()
		true

	setTotalMonthly: ->
		tot = @calcTotal("per month")
		@model.set("total_monthly", tot)
		@total_monthly_holder.html(accounting.formatMoney(tot, "$ "))
		# if tot > 0
		@total_monthly.show()
		# else
		# 			@total_monthly.hide()
		true

	setTotalQuarterly: ->
		tot = @calcTotal("per quarter")
		@model.set("total_quarterly", tot)
		@total_quarterly_holder.html(accounting.formatMoney(tot, "$ "))
		# if tot > 0
		@total_quarterly.show()
		# else
		# 			@total_quarterly.hide()
		true

	setTotalYearly: ->
		tot = @calcTotal("per year")
		@model.set("total_yearly", tot)
		@total_yearly_holder.html(accounting.formatMoney(tot, "$ "))
		# if tot > 0
		@total_yearly.show()
		# else
		# 			@total_yearly.hide()
		true
		
	saveModel: ->
		@vent.trigger('document:save_document')

	calcTotal: (total_unit) ->
		self = @
		sum = _.reduce(
			self.collection.models
			(memo, item) -> 
				if item.get("total_unit") == total_unit and not item.get("not_in_total")
					memo + item.get("total")
				else
					memo
			0
		)
		sum