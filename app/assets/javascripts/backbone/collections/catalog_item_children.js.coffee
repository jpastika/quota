class Quota.Collections.CatalogItemChildren extends Backbone.Collection

	model: Quota.Models.CatalogItemChild
	url: '/api/catalog_item_children'
	
	comparator: (c) ->
		return c.get("child_item").name.toLowerCase()
