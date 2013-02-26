class Quota.Models.ContactPhone extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/contact_phones'
	
	validation:
		val:
			required: true
			msg: "can't be blank"
	
	initialize: ->
		self = @
		
	
	remove: ->
		self = @
		@destroy({
			wait: false
			success:()-> 
				self.trigger('destroy:success',{model: self})
			error:()-> 
				self.trigger('destroy:error',{model: self})
		})