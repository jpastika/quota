class Quota.Views.SearchResultsDocumentsSubList extends Quota.Views.SearchResultsSubContainer

	addOne: (item)->
		view = new Quota.Views.SearchResultsDocument({model: item, tagName:'tr', vent: @vent})
		@_itemViews.push(view)
		view

