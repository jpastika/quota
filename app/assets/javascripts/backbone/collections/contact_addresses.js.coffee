class Quota.Collections.ContactAddresses extends Backbone.Collection
	
	model: Quota.Models.ContactAddress
	
	comparator: (c) ->
	  return c.get("name").toLowerCase()
	
	initialize: () ->
		@on('destroy:error', @model_destroy, @)
	
	model_destroy: (evt) ->
		# @trigger('destroy:error',{model: evt.model})
		# console.log evt.model.get("val")