class Quota.Views.ChooseTemplateTemplateDetailsListItems extends Backbone.View

	
	template: HandlebarsTemplates['documents/choose_template_template_details_list_items'] #Handlebars.compile($("#quote-document").html()) #JST['quotes/index']
	
	# el: '.template_items_container .template_items_rows ul'
	
	# events:
	# 		"update-sort": "updateOrder"

	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_itemViews = []
		@template_model = options.parent_model
		
	render: ->
		$(@el).empty()
		$(@el).html(@template())
		
		@items_container = @$('.template_items_rows ul')
		# $(@el).html(@document({}))
		
		if @collection.length > 0
			frag = document.createDocumentFragment()
			frag.appendChild(@addOne(item).render().el) for item in @collection.models
			@items_container.append(frag)
		else
			$(@el).html('This template has no items.')
		@

	addOne: (item)->
		view = new Quota.Views.ChooseTemplateTemplateDetailsListItem({model: item, tagName:'li', template_item: @model, parent_model: @template_model, vent: @vent})
		@_itemViews.push(view)
		view
		
	handleError: (attribute, message) ->
		# console.log message