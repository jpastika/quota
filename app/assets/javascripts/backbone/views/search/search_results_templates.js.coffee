class Quota.Views.SearchResultsTemplates extends Backbone.View
	
	template: HandlebarsTemplates['search/search_results_templates'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@templates_by_name = options.templates_by_name
		@templates_by_part_name = options.templates_by_part_name
		@templates_by_part_number = options.templates_by_part_number
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
		@templates_by_name_view = new Quota.Views.SearchResultsTemplatesSubList({collection: @templates_by_name, title: "matching Name", vent: @vent})
		@templates_by_part_name_view = new Quota.Views.SearchResultsTemplatesSubList({collection: @templates_by_part_name, title: "matching Part Name", vent: @vent})
		@templates_by_part_number_view = new Quota.Views.SearchResultsTemplatesSubList({collection: @templates_by_part_number, title: "matching Part Number", vent: @vent})
		
	render: ->
		$(@el).html(@template())
		# @
		
		@items = @$('.search_results_table_rows')
		frag = document.createDocumentFragment()
		
		if @templates_by_name.length
			frag.appendChild(@templates_by_name_view.render().el)
		if @templates_by_part_name.length
			frag.appendChild(@templates_by_part_name_view.render().el)
		if @templates_by_part_number.length
			frag.appendChild(@templates_by_part_number_view.render().el)
		@items.append(frag)
		@