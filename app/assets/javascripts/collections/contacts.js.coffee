class Quota.Collections.Contacts extends Backbone.Collection

	model: Quota.Models.Contact
	url: '/api/contacts'
	
	comparator: (c) ->
	  return c.get("name").toLowerCase()
