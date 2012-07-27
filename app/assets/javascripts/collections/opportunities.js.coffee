class Quota.Collections.Opportunities extends Backbone.Collection

	model: Quota.Models.Opportunity
	url: '/api/opportunities'
	
	comparator: (c) ->
	  return c.get("name").toLowerCase()
