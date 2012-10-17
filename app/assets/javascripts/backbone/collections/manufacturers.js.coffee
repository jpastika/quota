class Quota.Collections.Manufacturers extends Backbone.Collection

	model: Quota.Models.Manufacturer
	url: '/api/manufacturers'
	
	comparator: (c) ->
	  return c.get("manufacturer").toLowerCase()
