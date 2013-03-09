class Quota.Views.ChooseTemplateTemplateDetails extends Backbone.View
	
	template: HandlebarsTemplates['documents/choose_template_template_details'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	# events:
	# 		
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		
		@template_items = new Quota.Collections.TemplateItems(@model.get("template_items"))
		
		@_itemsView = new Quota.Views.ChooseTemplateTemplateDetailsListItems({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@template_items, vent: @vent})
		
	render: ->
		$(@el).empty()
		$(@el).html(@template({template:@model.toJSON()}))
		
		@container_items = @$('.template_items_container')
		@_itemsView.setElement(@container_items).render()
		
		@