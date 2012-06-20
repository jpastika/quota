class Quota.Views.Document_Title extends Backbone.View

	template: HandlebarsTemplates['documents/document_title'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	el: 'title'
	
	initialize: ->
		@model.on('change', @render, this)
		
	render: ->
		$(@el).html(@template({document:@model.toJSON()}))
		this
