class Quota.Views.SearchResultsOpportunitiesContainer extends Quota.Views.SearchResultsContainer
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@opportunities_by_name = options.opportunities_by_name
		@opportunities_by_company = options.opportunities_by_company
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
		@opportunities_view = new Quota.Views.SearchResultsOpportunities({opportunities_by_name: @opportunities_by_name, opportunities_by_company: @opportunities_by_company, vent: @vent})
		
	render: ->
		$(@el).html(@template({opportunities_by_name:@opportunities_by_name.toJSON(), opportunities_by_company:@opportunities_by_company.toJSON(), title: "Opportunities", cnt: (@opportunities_by_name.length + @opportunities_by_company.length)}))
		# @
		
		@items = @$('.search_results_container_rows')
		frag = document.createDocumentFragment()
		
		frag.appendChild(@opportunities_view.render().el)
		@items.append(frag)
		
		@