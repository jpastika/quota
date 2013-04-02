class Quota.Views.SearchResultsContainer extends Backbone.View

	template: HandlebarsTemplates['search/search_results_container'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .search_results_container-chevron:first" : "handleClickChevron"
		# "click .search_results_container-down:first" : "handleClickExpand"
		# 		"click .search_results_container-up:first" : "handleClickCollapse"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
	handleClickChevron: (evt)->
		if $(evt.target).hasClass('icon-chevron-down')
			$(evt.target).addClass('icon-chevron-up').removeClass('icon-chevron-down')
			@$('.search_results_container_rows:first').show()
		else
			$(evt.target).addClass('icon-chevron-down').removeClass('icon-chevron-up')
			@$('.search_results_container_rows:first').hide()	

	handleClickExpand: ->
		@$('.search_results_container-down:first').addClass('icon-chevron-up').removeClass('icon-chevron-down')
		@$('.search_results_container_rows:first').show()
	
	handleClickCollapse: ->
		@$('.search_results_container-up:first').addClass('icon-chevron-down').removeClass('icon-chevron-up')
		@$('.search_results_container_rows:first').hide()
