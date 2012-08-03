class Quota.Views.ShowOpportunitySidebarFieldsApp extends Backbone.View

	template: HandlebarsTemplates['opportunities/show_opp_sidebar_fields_app'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		$(@el).html(@template({}))
		@
