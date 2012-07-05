class Quota.Views.ContactTypesToggle extends Backbone.View

	template: HandlebarsTemplates['contact_types/contact_type_toggle'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click input:radio": "clicked"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@model.on('change', @render, @)
		
	render: ->
		$(@el).html(@template({contact_type:@model.toJSON()}))
		@input = @$('input:radio');
		@
	
	clicked: ->
		@vent.trigger('contact_type:clicked')
	
	select: ->
		@input.attr("checked", "checked")
		
	deselect: ->
		@input.attr('checked', false)