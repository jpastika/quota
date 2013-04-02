class Quota.Views.SearchResultsCategoryOpportunities extends Quota.Views.SearchResultsCategory

	handleClick: (evt)->
		if $(evt.target).is(':checked')
			self.vent.trigger('category:show', {category: "opportunities"})
		else
			self.vent.trigger('category:hide', {category: "opportunities"})