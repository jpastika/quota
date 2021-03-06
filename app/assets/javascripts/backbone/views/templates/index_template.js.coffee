class Quota.Views.IndexTemplate extends Backbone.View

	template: HandlebarsTemplates['template/index_template'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .icon-remove": "destroy"
		"click .template_link": "templateLinkClicked"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@template_model = options.template_model
		@vent = options.vent
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({template:@model.toJSON()}))
		@
		
	destroy: (evt) ->
		@toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		
	toggle: () ->
		$(@el).toggle()
		
	templateLinkClicked: ->
		@vent.trigger("template_link:clicked", {view: @})