class Quota.Views.SearchResultsContactsSubList extends Quota.Views.SearchResultsSubContainer

	addOne: (item)->
		view = new Quota.Views.SearchResultsContact({model: item, tagName:'tr', vent: @vent})
		@_itemViews.push(view)
		view

