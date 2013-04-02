class Quota.Views.SearchResultsDocumentsContainer extends Quota.Views.SearchResultsContainer

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
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
		@documents_view = new Quota.Views.SearchResultsDocuments({documents_by_name:@documents_by_name, documents_by_opportunity_name:@documents_by_opportunity_name, documents_by_opportunity_company_name:@documents_by_opportunity_company_name, documents_by_po:@documents_by_po, documents_by_part_number:@documents_by_part_number, documents_by_part_name:@documents_by_part_name, vent: @vent})
		
	render: ->
		$(@el).html(@template({documents_by_name:@documents_by_name.toJSON(), documents_by_opportunity_name:@documents_by_opportunity_name.toJSON(), documents_by_opportunity_company_name:@documents_by_opportunity_company_name.toJSON(), documents_by_po:@documents_by_po.toJSON(), documents_by_part_number:@documents_by_part_number.toJSON(), documents_by_part_name:@documents_by_part_name.toJSON(), title: "Documents", cnt: (@documents_by_name.length + @documents_by_opportunity_name.length + @documents_by_opportunity_company_name.length + @documents_by_po.length + @documents_by_part_number.length + @documents_by_part_name.length)}))
		@
		# @
		
		@items = @$('.search_results_container_rows')
		frag = document.createDocumentFragment()
		
		frag.appendChild(@documents_view.render().el)
		@items.append(frag)
		
		@