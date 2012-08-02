class Quota.Collections.SalesReps extends Backbone.Collection

	model: Quota.Models.SalesRep
	url: '/api/salesreps'
	comparator: (m) ->
		return m.get("name")
