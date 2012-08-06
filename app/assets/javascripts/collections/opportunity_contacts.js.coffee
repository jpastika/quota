class Quota.Collections.OpportunityContacts extends Backbone.Collection

	model: Quota.Models.OpportunityContact
	url: '/api/opportunity_contacts'
	
	comparator: (c) ->
	  return c.get("name").toLowerCase()
