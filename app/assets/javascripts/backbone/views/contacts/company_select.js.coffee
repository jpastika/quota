class Quota.Views.CompanySelect extends Backbone.View

	template: HandlebarsTemplates['contacts/company_select'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"change select": "companyChanged"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@parent_child_key = options.parent_child_key
		@field_name = options.field_name
		@collection.on('change', @render, @)
		
	render: ->
		$(@el).html(@template({companies:@collection.toJSON(), field_name:@field_name}))
		@input_company_key = @$('select')
		@setSelected()
		@
		
	companyChanged: (obj) ->
		company = _.find(@collection.models, (m) -> m.get("pub_key") == obj.target.value)
		if company
			@vent.trigger('company:changed',{company: company})
			
	setSelected: ->
		@input_company_key.val(@parent_child_key)
