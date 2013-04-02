class Quota.Views.SearchResultsCategoryTemplates extends Quota.Views.SearchResultsCategory

	handleClick: (evt)->
		if $(evt.target).is(':checked')
			self.vent.trigger('category:show', {category: "templates"})
		else
			self.vent.trigger('category:hide', {category: "templates"})