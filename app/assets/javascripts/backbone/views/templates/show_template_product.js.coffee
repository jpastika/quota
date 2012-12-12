class Quota.Views.ShowTemplateProduct extends Backbone.View

	template: HandlebarsTemplates['template/show_template_product'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .template_item_remove": "destroy"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@item = options.item
		@vent = options.vent
		@hideRemove = if options.hideRemove then options.hideRemove else false
		@model.on('destroy', @remove, @)

	render: ->
		$(@el).html(@template({template_item:@model.toJSON()}))
		if @hideRemove
			@$('.template_item_remove').css('visibility', 'hidden')
		@

	destroy: (evt) ->
		$(@el).toggle()
		# @model.trigger('removing', {view: @})
		@model.remove()
		@vent.trigger('template_products:remove_template_item', {model: @model})
		

	hideRemove: () ->
		@hideRemove = true
		$(@el).find('.template_item_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		$(@el).find('.template_item_remove').css('visibility', '')