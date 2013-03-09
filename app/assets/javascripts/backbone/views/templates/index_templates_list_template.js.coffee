class Quota.Views.IndexTemplatesListTemplate extends Backbone.View

	template: HandlebarsTemplates['template/index_templates_list_template'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .template_name": "templateClicked"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@template_model = options.template
		# @contact_types = options.contact_types
		@vent = options.vent
		
	render: ->
		# @contact_type = @getContactType()
		$(@el).html(@template({template:@model.toJSON()}))
		@
		
	toggle: () ->
		$(@el).toggle()
		
	templateClicked: ->
		@vent.trigger("template:clicked", {model: @model, view: @})
		
	highlight: ->
		$(@el).addClass('row_selected')
	
	unhighlight: ->
		$(@el).removeClass('row_selected')