class Quota.Views.SearchResultsDocuments extends Backbone.View
	
	template: HandlebarsTemplates['search/search_results_documents'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
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
		
		@documents_by_name_view = new Quota.Views.SearchResultsDocumentsSubList({collection: @documents_by_name, title: "matching Name", vent: @vent})
		@documents_by_opportunity_name_view = new Quota.Views.SearchResultsDocumentsSubList({collection: @documents_by_opportunity_name, title: "matching Opportunity", vent: @vent})
		@documents_by_opportunity_company_name_view = new Quota.Views.SearchResultsDocumentsSubList({collection: @documents_by_opportunity_company_name, title: "matching Company", vent: @vent})
		@documents_by_po_view = new Quota.Views.SearchResultsDocumentsSubList({collection: @documents_by_po, title: "matching PO", vent: @vent})
		@documents_by_part_number_view = new Quota.Views.SearchResultsDocumentsSubList({collection: @documents_by_part_number, title: "matching Part Number", vent: @vent})
		@documents_by_part_name_view = new Quota.Views.SearchResultsDocumentsSubList({collection: @documents_by_part_name, title: "matching Part Name", vent: @vent})
	
	render: ->
		$(@el).html(@template())
		
		@items = @$('.search_results_table_rows')
		frag = document.createDocumentFragment()
		
		if @documents_by_name.length
			frag.appendChild(@documents_by_name_view.render().el)
		if @documents_by_opportunity_name.length
			frag.appendChild(@documents_by_opportunity_name_view.render().el)
		if @documents_by_opportunity_company_name.length
			frag.appendChild(@documents_by_opportunity_company_name_view.render().el)
		if @documents_by_po.length
			frag.appendChild(@documents_by_po_view.render().el)
		if @documents_by_part_number.length
			frag.appendChild(@documents_by_part_number_view.render().el)
		if @documents_by_part_name.length
			frag.appendChild(@documents_by_part_name_view.render().el)
		@items.append(frag)
		@