class Quota.Views.SearchResultsCategoriesContainer extends Backbone.View

	el: '.search_categories'
	
	# events:
		# "click .search_results_container-chevron:first" : "handleClickChevron"
		# "click .search_results_container-down:first" : "handleClickExpand"
		# 		"click .search_results_container-up:first" : "handleClickCollapse"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@documents_by_name = options.documents_by_name
		@documents_by_opportunity_name = options.documents_by_opportunity_name
		@documents_by_opportunity_company_name = options.documents_by_opportunity_company_name
		@documents_by_po = options.documents_by_po
		@documents_by_part_number = options.documents_by_part_number
		@documents_by_part_name = options.documents_by_part_name
		@opportunities_by_name = options.opportunities_by_name
		@opportunities_by_company = options.opportunities_by_company
		@templates_by_name = options.templates_by_name
		@templates_by_part_name = options.templates_by_part_name
		@templates_by_part_number = options.templates_by_part_number
		@contacts_by_name = options.contacts_by_name
		@contacts_by_company = options.contacts_by_company
		@catalog_items_by_name = options.catalog_items_by_name
		@catalog_items_by_part_number = options.catalog_items_by_part_number
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		@opportunities_category_view = new Quota.Views.SearchResultsCategoryOpportunities({title: "Opportunities", cnt: (@opportunities_by_name.length + @opportunities_by_company.length)})
		
		@documents_category_view = new Quota.Views.SearchResultsCategoryDocuments({title: "Documents", cnt: (@documents_by_name.length + @documents_by_opportunity_name.length + @documents_by_opportunity_company_name.length + @documents_by_po.length + @documents_by_part_number.length + @documents_by_part_name.length)})
		
		@templates_category_view = new Quota.Views.SearchResultsCategoryTemplates({title: "Templates", cnt: (@templates_by_name.length + @templates_by_part_name.length + @templates_by_part_number.length)})
		
		@contacts_category_view = new Quota.Views.SearchResultsCategoryContacts({title: "Contacts", cnt: (@contacts_by_name.length + @contacts_by_company.length)})
		
		@catalog_items_category_view = new Quota.Views.SearchResultsCategoryCatalogItems({title: "Catalog Items", cnt: (@catalog_items_by_name.length + @catalog_items_by_part_number.length)})
		
		
	render: ->
		@$el.empty()
		frag = document.createDocumentFragment()
		
		if @opportunities_by_name.length || @opportunities_by_company.length
			frag.appendChild(@opportunities_category_view.render().el)
		if @documents_by_name.length || @documents_by_opportunity_name.length || @documents_by_opportunity_company_name.length || @documents_by_po.length || @documents_by_part_number.length || @documents_by_part_name.length
			frag.appendChild(@documents_category_view.render().el)
		if @contacts_by_name.length || @contacts_by_company.length
			frag.appendChild(@contacts_category_view.render().el)
		if @templates_by_name.length || @templates_by_part_name.length || @templates_by_part_number.length
			frag.appendChild(@templates_category_view.render().el)
		if @catalog_items_by_name.length || @catalog_items_by_part_number.length
			frag.appendChild(@catalog_items_category_view.render().el)
		@$el.append(frag)
		
		@
		
	# handleClickChevron: (evt)->
	# 		if $(evt.target).hasClass('icon-chevron-down')
	# 			$(evt.target).addClass('icon-chevron-up').removeClass('icon-chevron-down')
	# 			@$('.search_results_container_rows:first').show()
	# 		else
	# 			$(evt.target).addClass('icon-chevron-down').removeClass('icon-chevron-up')
	# 			@$('.search_results_container_rows:first').hide()	