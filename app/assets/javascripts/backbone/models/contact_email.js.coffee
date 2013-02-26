class Quota.Models.ContactEmail extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/contact_emails'
	
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