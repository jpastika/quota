class Quota.Views.ShowContactPhone extends Backbone.View

	template: HandlebarsTemplates['contacts/show_contact_phone'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@contact = options.contact
		@vent = options.vent
		
	render: ->
		$(@el).html(@template({contact_phone:@model.toJSON()}))
		@