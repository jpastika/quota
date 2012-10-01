class Quota.Models.ContactUrl extends Backbone.Model
	idAttribute: 'pub_key'
	
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