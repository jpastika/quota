class Quota.Views.SalesRepSelect extends Backbone.View

	template: HandlebarsTemplates['sales_reps/sales_rep_select'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"change select": "salesRepChanged"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@parent_child_key = options.parent_child_key
		@field_name = options.field_name
		@collection.on('change', @render, @)
		
	render: ->
		$(@el).html(@template({sales_reps:@collection.toJSON(), field_name:@field_name}))
		@input_sales_rep_key = @$('select')
		@setSelected()
		@
		
	salesRepChanged: (obj) ->
		sales_rep = _.find(@collection.models, (m) -> m.get("pub_key") == obj.target.value)
		if sales_rep
			@vent.trigger('sales_rep:changed',{sales_rep: sales_rep})
			
	setSelected: ->
		@input_sales_rep_key.val(@parent_child_key)
