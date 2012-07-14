class Quota.Collections.Companies extends Backbone.Collection

	model: Quota.Models.Contact
	url: '/api/companies'
	
	comparator: (c) ->
	  return c.get("name").toLowerCase()
