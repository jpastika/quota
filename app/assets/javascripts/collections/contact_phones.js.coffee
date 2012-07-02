class Quota.Collections.ContactPhones extends Backbone.Collection
	
	model: Quota.Models.ContactPhone
	
	setup_new: ->
		@reset([{name:'', val:''}])
	# url: ->
	# 		return '/api/contact/'+ @contact_key +'/phones'
	
	# initialize: (models, options) ->
	# 		console.log models
	# 		@contact_key = options.contact_key