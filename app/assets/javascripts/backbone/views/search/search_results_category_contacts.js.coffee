class Quota.Views.SearchResultsCategoryContacts extends Quota.Views.SearchResultsCategory

	handleClick: (evt)->
		if $(evt.target).is(':checked')
			self.vent.trigger('category:show', {category: "contacts"})
		else
			self.vent.trigger('category:hide', {category: "contacts"})