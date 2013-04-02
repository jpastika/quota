class Quota.Views.SearchResultsCatalogItemsSubList extends Quota.Views.SearchResultsSubContainer

	addOne: (item)->
		view = new Quota.Views.SearchResultsCatalogItem({model: item, tagName:'tr', vent: @vent})
		@_itemViews.push(view)
		view

