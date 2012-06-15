class Quota.Views.Edit_Quote_Name extends Backbone.View

	template: HandlebarsTemplates['quotes/edit_quote_name'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	className: 'editable-value'
	
	initialize: ->
		@model.on('change', @render, this)
		
	render: ->
		$(@el).html(@template({quote:@model.toJSON()}))
		this
