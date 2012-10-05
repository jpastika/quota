class Quota.Collections.Templates extends Backbone.Collection

	model: Quota.Models.Template
	url: '/api/templates'
	
	comparator: (c) ->
	  return c.get("name").toLowerCase()
