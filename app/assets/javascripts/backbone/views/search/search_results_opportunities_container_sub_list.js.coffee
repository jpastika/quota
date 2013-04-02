class Quota.Views.SearchResultsOpportunitiesSubList extends Quota.Views.SearchResultsSubContainer

	addOne: (item)->
		view = new Quota.Views.SearchResultsOpportunity({model: item, tagName:'tr', vent: @vent})
		@_itemViews.push(view)
		view

	