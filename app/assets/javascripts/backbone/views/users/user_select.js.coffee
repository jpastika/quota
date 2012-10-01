class Quota.Views.UserSelect extends Backbone.View

	template: HandlebarsTemplates['users/user_select'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"change select": "userChanged"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@parent_child_key = options.parent_child_key
		@field_name = options.field_name
		@collection.on('change', @render, @)
		
	render: ->
		$(@el).html(@template({users:@collection.toJSON(), field_name:@field_name}))
		@input_user_key = @$('select')
		@setSelected()
		@
		
	userChanged: (obj) ->
		user = _.find(@collection.models, (m) -> m.get("pub_key") == obj.target.value)
		if user
			@vent.trigger('user:changed',{user: user})
			
	setSelected: ->
		@input_user_key.val(@parent_child_key)
