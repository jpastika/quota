class Quota.Models.ContactAddress extends Backbone.Model
	idAttribute: 'pub_key'
	
	# validation:
	# 		val:
	# 			required: true
	# 			msg: "can't be blank"
	
	# validate: ->
	# 		true
	
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