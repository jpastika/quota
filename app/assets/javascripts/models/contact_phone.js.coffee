class Quota.Models.ContactPhone extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/contact_phones'
	
	initialize: ->
		self = @
	
	clear: ->
		self = @
		@destroy({
			wait: false
			success:()-> 
				self.trigger('destroy:success',{model: self})
			error:()-> 
				self.trigger('destroy:error',{model: self})
		})