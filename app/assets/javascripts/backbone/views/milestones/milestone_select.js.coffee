class Quota.Views.MilestoneSelect extends Backbone.View

	template: HandlebarsTemplates['milestones/milestone_select'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"change select": "milestoneChanged"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@parent_child_key = options.parent_child_key
		@field_name = options.field_name
		# @collection.on('change', @render, @)
		
	render: ->
		$(@el).html(@template({milestones:@collection.toJSON(), field_name:@field_name}))
		@input_opportunity_milestone_key = @$('select')
		@setSelected()
		@
		
	milestoneChanged: (obj) ->
		milestone = _.find(@collection.models, (m) -> m.get("pub_key") == obj.target.value)
		if milestone
			@vent.trigger('milestone:changed',{milestone: milestone})
			
	setSelected: ->
		@input_opportunity_milestone_key.val(@parent_child_key)
		