class Quota.Views.ChooseTemplate extends Backbone.View

	el: 'body'
	
	# events:
	# 		"focus .template_items_shim" : "handleTemplateItemsShimFocus"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@_templateSearchView = new Quota.Views.ChooseTemplateTemplateSearch({vent: @vent})
		@vent.on("template_combo:item_selected", @templateSelected)
		
	render: ->
		@container_search = @$('#search_field_container')
		
		@_templateSearchView.setElement(@container_search).render()
		@input_template_key = @$('.document_template_key')
		@

	setup: ->
		@container_search = @$('#search_field_container')
	
		@_templateSearchView.setElement(@container_search).render()
		@input_template_key = @$('.document_template_key')
		
		
	templateSelected: (obj) ->
		@input_template_key.val(obj.template.pub_key)