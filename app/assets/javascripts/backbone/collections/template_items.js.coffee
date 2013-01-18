class Quota.Collections.TemplateItems extends Backbone.Collection

	model: Quota.Models.TemplateItem
	url: '/api/template_items'
	
	comparator: (c) ->
		return c.get("sort_order")
