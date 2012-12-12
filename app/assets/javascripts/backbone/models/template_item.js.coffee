class Quota.Models.TemplateItem extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/template_items'
	
	defaults: {
	}
	
	# validation:
	# 		name:
	# 			required: true
	# 			msg: "can't be blank"
	# 	
	initialize: ->
		
	remove: ->
		self = @
		@destroy({
			wait: false
			success:()-> 
				self.trigger('destroy:success',{model: self})
			error:()-> 
				self.trigger('destroy:error',{model: self})
		})