class Quota.Views.ContactPhone extends Backbone.View

	template: HandlebarsTemplates['contacts/contact_phone'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events: {
	}
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@model.on('change', @render, @)
		
	render: ->
		$(@el).html(@template({contact_phone:@model.toJSON()}))
		@