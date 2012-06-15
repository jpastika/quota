class Quota.Views.Quote_Title extends Backbone.View

	template: HandlebarsTemplates['quotes/quote_title'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	el: 'title'
	
	initialize: ->
		@model.on('change', @render, this)
		
	render: ->
		$(@el).html(@template({quote:@model.toJSON()}))
		this
