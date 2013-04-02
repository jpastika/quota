class Quota.Views.SearchResultsSubContainer extends Backbone.View

	template: HandlebarsTemplates['search/search_results_subcontainer'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-chevron-down" : "handleClickExpand"
		"click .icon-chevron-up" : "handleClickCollapse"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@_itemViews = []
		@title = options.title
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
	render: ->
		$(@el).html(@template({title: @title, cnt: @collection.models.length}))

		@items = @$('.search_results_subcontainer_rows tbody')

		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@items.append(frag)
		@
		
	handleClickExpand: ->
		@$('.icon-chevron-down').removeClass('icon-chevron-down').addClass('icon-chevron-up')
	
	handleClickCollapse: ->
		@$('.icon-chevron-up').removeClass('icon-chevron-up').addClass('icon-chevron-down')
