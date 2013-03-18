class Quota.Views.ChooseTemplate extends Backbone.View

	el: 'body'
	
	events:
		"keyup .search-bar input": "handleSearch"
		"click .search-bar .icon-remove": "handleClearSearch"
		"click .start_empty button": "handleStartEmpty"
	# 		"focus .template_items_shim" : "handleTemplateItemsShimFocus"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@templates = options.templates
		@vent.on("template:clicked", @templateClicked, @)
		
		# @_templateSearchView = new Quota.Views.ChooseTemplateTemplateSearch({vent: @vent})
		@_templates_list_view = new Quota.Views.ChooseTemplateListTemplates({collection: @templates, vent: @vent})
		# @vent.on("template_combo:item_selected", @templateSelected)
		
	# render: ->
	# 		@container_search = @$('#search_field_container')
	# 		
	# 		@_templateSearchView.setElement(@container_search).render()
	# 		@input_template_key = @$('.document_template_key')
	# 		@
	# 
	# 	setup: ->
	# 		@container_search = @$('#search_field_container')
	# 	
	# 		@_templateSearchView.setElement(@container_search).render()
	# 		@input_template_key = @$('.document_template_key')
	# 		
	# 		
	# 	templateSelected: (obj) ->
	# 		@input_template_key.val(obj.template.pub_key)
	# 		
	# 		
	render: ->
		$(@el).empty()
		$(@el).html(@template())

		@_templates_list_view.render()
		# @contactView.render()

		@search = @$('.search-bar input')
		@search_found = @$('.search-bar .found')
		@search_found_count = @$('.search-bar .found_count')
		@template_key = @$('.document_template_key')
		
		@

	setup: ->
		# @view = new Quota.Views.ListContacts({collection: @contacts, vent: @vent})
		@_templates_list_view.render()
		# @contactView.render()
		@search = @$('.search-bar input')
		@search_found = @$('.search-bar .found')
		@search_found_count = @$('.search-bar .found_count')
		@template_key = @$('.document_template_key')



	handleSearch: ->
		self = @
		
		if @search.val() != ''
			res = new Quota.Collections.Templates()
			res.fetch(
				{
					url: '/api/templates/filter_by_name_or_item'
					data: {filter: @search.val()}
					error: ->
						console.log "error"
					success: (collection, response, options) -> 
						self.renderSearchResults(collection)
						self.setFoundCount(collection.length)
						self.showFound()
				}
			)
			
			# filterParams = {name:[@search.val()]}
			# 			filtered_contacts = @contacts.clone()
			# 			filtered_contacts.filterData(filterParams, 'and');
			# 			@view.collection = filtered_contacts
			# 			@setFoundCount(filtered_contacts.length)
			# 			@showFound()
			# 			@view.render()
		else
			@handleClearSearch()
			
	renderSearchResults: (collection)->
		# @$('#catalog_search_container').show()
		@_templates_list_view.collection = collection
		@_templates_list_view.render()

	handleClearSearch: ->
		@_templates_list_view.collection = @templates
		@search.val('')
		@hideFound()
		@_templates_list_view.render()

	showFound: ->
		@search_found.show()

	hideFound: ->
		@search_found.hide()

	setFoundCount: (cnt) ->
		@search_found_count.html(cnt)

	templateClicked: (evt) ->
		self = @
		@template_key.val(evt.model.get("pub_key"))
		
		@template = new Quota.Models.Template({pub_key: @template_key.val()})
		@template.fetch(
			{
				success: (model, response, options)->
					self.templateView = new Quota.Views.ChooseTemplateTemplateDetails({model: model, el: '.template_details', vent: self.vent})
					self.templateView.render()
			}
		)
		
		
	handleStartEmpty: ->
		@template_key.val('')
		@$('form').submit()
		
		