class Quota.Views.SearchResults extends Backbone.View

	el: '.search_results'
	
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
		
		@opportunities_container_view = new Quota.Views.SearchResultsOpportunitiesContainer({opportunities_by_name: @opportunities_by_name, opportunities_by_company: @opportunities_by_company, tagName:'div', vent: @vent})
		
		@documents_container_view = new Quota.Views.SearchResultsDocumentsContainer({documents_by_name: @documents_by_name, documents_by_opportunity_name: @documents_by_opportunity_name, documents_by_opportunity_company_name: @documents_by_opportunity_company_name, documents_by_po: @documents_by_po, documents_by_part_number: @documents_by_part_number, documents_by_part_name: @documents_by_part_name, tagName:'div', vent: @vent})
		
		@contacts_container_view = new Quota.Views.SearchResultsContactsContainer({contacts_by_name: @contacts_by_name, contacts_by_company: @contacts_by_company, tagName:'div', vent: @vent})
		
		@templates_container_view = new Quota.Views.SearchResultsTemplatesContainer({templates_by_name: @templates_by_name, templates_by_part_name: @templates_by_part_name, templates_by_part_number: @templates_by_part_number, tagName:'div', vent: @vent})
		
		@catalog_items_container_view = new Quota.Views.SearchResultsCatalogItemsContainer({catalog_items_by_name: @catalog_items_by_name, catalog_items_by_part_number: @catalog_items_by_part_number, tagName:'div', vent: @vent})
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
	render: ->
		@$el.empty()
		frag = document.createDocumentFragment()
		
		if @opportunities_by_name.length || @opportunities_by_company.length
			frag.appendChild(@opportunities_container_view.render().el)
		if @documents_by_name.length || @documents_by_opportunity_name.length || @documents_by_opportunity_company_name.length || @documents_by_po.length || @documents_by_part_number.length || @documents_by_part_name.length
			frag.appendChild(@documents_container_view.render().el)
		if @contacts_by_name.length || @contacts_by_company.length
			frag.appendChild(@contacts_container_view.render().el)
		if @templates_by_name.length || @templates_by_part_name.length || @templates_by_part_number.length
			frag.appendChild(@templates_container_view.render().el)
		if @catalog_items_by_name.length || @catalog_items_by_part_number.length
			frag.appendChild(@catalog_items_container_view.render().el)
		@$el.append(frag)
		@
