class Quota.Views.SearchResultsContainer extends Backbone.View

	template: HandlebarsTemplates['search/search_results_container'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-chevron-down" : "handleClickExpand"
		"click .icon-chevron-up" : "handleClickCollapse"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
	handleClickExpand: ->
		@$('.icon-chevron-down').removeClass('icon-chevron-down').addClass('icon-chevron-up')
	
	handleClickCollapse: ->
		@$('.icon-chevron-up').removeClass('icon-chevron-up').addClass('icon-chevron-down')
