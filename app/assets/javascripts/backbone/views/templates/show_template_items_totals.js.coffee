class Quota.Views.ShowTemplateItemsTotals extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	el: '#items_totals_container'
	
	# events:
	# 		"update-sort": "updateOrder"
	
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		# $(@el).html(@template({}))
		
		@