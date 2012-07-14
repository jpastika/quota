class Quota.Collections.ContactUrls extends Backbone.Collection
	
	model: Quota.Models.ContactUrl
	
	comparator: (c) ->
	  return c.get("name").toLowerCase()
	
	initialize: () ->
		@on('destroy:error', @model_destroy, @)
	
	model_destroy: (evt) ->
		# @trigger('destroy:error',{model: evt.model})
		# console.log evt.model.get("val")