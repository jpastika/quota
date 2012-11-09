class Quota.Models.CatalogItem extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/catalog_items'

	defaults: {
	}

	validation:
		name:
			required: true
			msg: "can't be blank"

	initialize: ->