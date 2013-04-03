class Quota.Views.SearchResultsContacts extends Backbone.View
	
	template: HandlebarsTemplates['search/search_results_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@contacts_by_name = options.contacts_by_name
		@contacts_by_company = options.contacts_by_company
		
		# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
		# 		@vent.on('search:clicked', @searchClicked, @)
		
		@contacts_by_name_view = new Quota.Views.SearchResultsContactsSubList({collection: @contacts_by_name, title: "w/ matching Name", vent: @vent})
		@contacts_by_company_view = new Quota.Views.SearchResultsContactsSubList({collection: @contacts_by_company, title: "w/ matching Company", vent: @vent})
		
	render: ->
		$(@el).html(@template())
		# @
		
		@items = @$('.search_results_table_rows')
		frag = document.createDocumentFragment()
		
		if @contacts_by_name.length
			frag.appendChild(@contacts_by_name_view.render().el)
		if @contacts_by_company.length
			frag.appendChild(@contacts_by_company_view.render().el)
		@items.append(frag)
		@