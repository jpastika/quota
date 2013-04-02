class Quota.Views.SearchResultsTemplatesSubList extends Quota.Views.SearchResultsSubContainer

	addOne: (item)->
		view = new Quota.Views.SearchResultsTemplate({model: item, tagName:'tr', vent: @vent})
		@_itemViews.push(view)
		view

