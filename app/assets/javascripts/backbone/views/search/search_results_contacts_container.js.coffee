class Quota.Views.SearchResultsContactsContainer extends Quota.Views.SearchResultsContainer

	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@contacts_by_name = options.contacts_by_name
		@contacts_by_company = options.contacts_by_company
			
			# @vent.on('catalog_item_link:clicked', @catalogItemLinkClicked, @)
			# 		@vent.on('search:clicked', @searchClicked, @)
		
		@contacts_view = new Quota.Views.SearchResultsContacts({contacts_by_name: @contacts_by_name, contacts_by_company: @contacts_by_company, vent: @vent})

	render: ->
		$(@el).html(@template({contacts_by_name:@contacts_by_name.toJSON(), contacts_by_company:@contacts_by_company.toJSON(), title: "Contacts", cnt: (@contacts_by_name.length + @contacts_by_company.length)}))
		# @

		@items = @$('.search_results_container_rows')
		frag = document.createDocumentFragment()

		frag.appendChild(@contacts_view.render().el)
		@items.append(frag)
		@