class Quota.Collections.Contacts extends Backbone.Collection

	model: Quota.Models.Contact
	url: '/api/contacts'
	
	comparator: (c) ->
		return c.get("name").toLowerCase()
		
	filterData: (params, bool) ->
		@originalModels = @models.slice();
		self = @

		if bool == 'or'
			m = []
		else
			m = self.models

		_.each params, (val, key) ->
			if (typeof val) != 'object'
				val = [ val ]

			# self.models = _.map self.models, (m) ->
			# 				_.each val, (v) ->
			# 					m.get(key).indexOf(v) != -1
			# console.log val
			# 			console.log key

			if bool == 'or'
				m = _.union(m, _.filter self.models, (model) ->
					_.any val, (v) ->
						(model.get(key).toString().toLowerCase().indexOf(v.toLowerCase())) != -1)
			else
				m = _.filter m, (model) ->
					_.any val, (v) ->
						(model.get(key).toString().toLowerCase().indexOf(v.toLowerCase())) != -1

			# 				_.each val, (v) ->
			# 					(model.get(key).indexOf(v)) != -1
					# 						true
				# (_.indexOf val, model.get(key)) != -1

		self.models = m

		@reset(self.models)
	
	# filterData: (params, bool) ->
	# 		@originalModels = @models.slice();
	# 		self = @
	# 
	# 		if bool == 'or'
	# 			m = []
	# 		else
	# 			m = self.models
	# 
	# 		_.each params, (val, key) ->
	# 			if (typeof val) != 'object'
	# 				val = [ val ]
	# 
	# 			# self.models = _.map self.models, (m) ->
	# 			# 				_.each val, (v) ->
	# 			# 					m.get(key).indexOf(v) != -1
	# 			console.log key
	# 
	# 			if bool == 'or'
	# 				m = _.union(m, _.filter self.models, (model) ->
	# 					_.any val, (v) ->
	# 						(model.get(key).toString().indexOf(v)) != -1)
	# 			else
	# 				m = _.filter m, (model) ->
	# 					_.any val, (v) ->
	# 						(model.get(key).toString().indexOf(v)) != -1
	# 
	# 			# 				_.each val, (v) ->
	# 			# 					(model.get(key).indexOf(v)) != -1
	# 					# 						true
	# 				# (_.indexOf val, model.get(key)) != -1
	# 
	# 		self.models = m
	# 
	# 		@reset(self.models)
	
	# initialize: (options)->
	# 		# if options.url
	# 		@url = options.url
