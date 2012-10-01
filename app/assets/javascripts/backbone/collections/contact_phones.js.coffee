class Quota.Collections.ContactPhones extends Backbone.Collection
	
	model: Quota.Models.ContactPhone
	
	comparator: (c) ->
	  return c.get("name").toLowerCase()
	
	initialize: () ->
		@on('destroy:error', @model_destroy, @)
	
	model_destroy: (evt) ->
		# @trigger('destroy:error',{model: evt.model})
		# console.log evt.model.get("val")