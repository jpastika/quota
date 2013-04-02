class Quota.Views.SearchResultsCategoryDocuments extends Quota.Views.SearchResultsCategory

	handleClick: (evt)->
		if $(evt.target).is(':checked')
			self.vent.trigger('category:show', {category: "documents"})
		else
			self.vent.trigger('category:hide', {category: "documents"})