class Quota.Views.SearchResultsOpportunities extends Backbone.View
	
	template: HandlebarsTemplates['search/search_results_opportunities'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@opportunities_by_name = options.opportunities_by_name
		@opportunities_by_company = options.opportunities_by_company
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
		@opportunities_by_name_view = new Quota.Views.SearchResultsOpportunitiesSubList({collection: @opportunities_by_name, title: "w/ matching Name", vent: @vent})
		@opportunities_by_company_view = new Quota.Views.SearchResultsOpportunitiesSubList({collection: @opportunities_by_company, title: "w/ matching Company", vent: @vent})
		
	render: ->
		$(@el).html(@template())
		# @
		
		@items = @$('.search_results_table_rows')
		frag = document.createDocumentFragment()
		
		if @opportunities_by_name.length
			frag.appendChild(@opportunities_by_name_view.render().el)
		if @opportunities_by_company.length
			frag.appendChild(@opportunities_by_company_view.render().el)
		@items.append(frag)
		@