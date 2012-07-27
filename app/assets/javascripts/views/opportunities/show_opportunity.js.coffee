class Quota.Views.ShowOpportunity extends Backbone.View

	template: HandlebarsTemplates['opportunities/show_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		
	render: ->
		$(@el).html(@template({contact:@model.toJSON()}))
		@
