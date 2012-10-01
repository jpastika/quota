class Quota.Views.Edit_Document_Name extends Backbone.View

	template: HandlebarsTemplates['documents/edit_document_name'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: ->
		@model.on('change', @render, this)
		
	render: ->
		$(@el).html(@template({document:@model.toJSON()}))
		this
