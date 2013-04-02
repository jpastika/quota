class Quota.Views.SearchResultsCategoryCatalogItems extends Quota.Views.SearchResultsCategory

	handleClick: (evt)->
		if $(evt.target).is(':checked')
			self.vent.trigger('category:show', {category: "catalog items"})
		else
			self.vent.trigger('category:hide', {category: "catalog items"})