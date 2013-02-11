class Quota.Collections.DocumentItems extends Backbone.Collection

	model: Quota.Models.DocumentItem
	url: '/api/document_items'
	
	comparator: (c) ->
		return c.get("sort_order")
