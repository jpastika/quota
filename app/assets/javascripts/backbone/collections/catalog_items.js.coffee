class Quota.Collections.CatalogItems extends Backbone.Collection

	model: Quota.Models.CatalogItem
	url: '/api/catalog_items'
	
	filterData: (params) ->
		@originalModels = @models.slice();
		self = @
		
		_.each params, (val, key) ->
			if (typeof val) != 'object'
				val = [ val ]
				
			self.models = _.filter self.models, (model) ->
				_.each val, (v) ->
					(model.get(key).indexOf(v)) != -1
					# 						true
				# (_.indexOf val, model.get(key)) != -1
		
		@reset(self.models)
