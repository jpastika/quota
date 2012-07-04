class Quota.Collections.ContactPhones extends Backbone.Collection
	
	model: Quota.Models.ContactPhone
	
	# setup_new: ->
	# 		@reset([{name:'', val:''}])
	# url: ->
	# 		return '/api/contact/'+ @contact_key +'/phones'
	
	initialize: () ->
		@on('destroy:error', @model_destroy, @)
	
	model_destroy: (evt) ->
		# @trigger('destroy:error',{model: evt.model})
		# console.log evt.model.get("val")