class Quota.Views.ContactPhone extends Backbone.View

	template: HandlebarsTemplates['contacts/contact_phone'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: ->
		@model.on('change', @render, this)
		
	render: ->
		$(@el).html(@template({contact_phone:@model.toJSON()}))
		this
