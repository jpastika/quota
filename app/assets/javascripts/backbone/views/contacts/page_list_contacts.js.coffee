class Quota.Views.PageListContacts extends Backbone.View
	
	# template: HandlebarsTemplates['contacts/page_list_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: "body"
	
	events:
		"click .add_contact": "handleAddContactClick"
		"keyup .search-bar input": "handleSearch"
		"click .search-bar .icon-remove": "handleClearSearch"
		
		
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		# @contact_types = options.contact_types
		@contacts = options.contacts
		@vent.on("contact:clicked", @contactClicked, @)
		@vent.on("contact:save_new_successful", @contactAdded, @)
		@vent.on("contact:updated", @contactUpdated)
		@view = new Quota.Views.ListContacts({collection: @contacts, vent: @vent})
		# @contactView = new Quota.Views.IndexContactAdd({model: new Quota.Models.Contact() , vent: @vent})
		# @searchView = new Quota.Views.ListContactsSearch({collection: @contacts, vent: @vent})
	
	render: ->
		$(@el).empty()
		$(@el).html(@template())
		
		@view.render()
		# @contactView.render()
		
		@search = @$('.search-bar input')
		@search_found = @$('.search-bar .found')
		@search_found_count = @$('.search-bar .found_count')
		@
		
	setup: ->
		# @view = new Quota.Views.ListContacts({collection: @contacts, vent: @vent})
		@view.render()
		# @contactView.render()
		@search = @$('.search-bar input')
		@search_found = @$('.search-bar .found')
		@search_found_count = @$('.search-bar .found_count')
		
		
	handleSearch: ->
		if @search.val() != ''
			filterParams = {name:[@search.val()]}
			filtered_contacts = @contacts.clone()
			filtered_contacts.filterData(filterParams, 'and');
			@view.collection = filtered_contacts
			@setFoundCount(filtered_contacts.length)
			@showFound()
			@view.render()
		else
			@handleClearSearch()
		
	
	handleClearSearch: ->
		@view.collection = @contacts
		@search.val('')
		@hideFound()
		@view.render()
		
	showFound: ->
		@search_found.show()
		
	hideFound: ->
		@search_found.hide()
		
	setFoundCount: (cnt) ->
		@search_found_count.html(cnt)

	contactClicked: (evt) ->
		@contactView = new Quota.Views.IndexContact({model: evt.model, vent: @vent})
		@contactView.render()
		
	handleAddContactClick: ->
		@contactView = new Quota.Views.IndexContactAdd({model: new Quota.Models.Contact() , vent: @vent})
		@contactView.render()
		
	contactUpdated: (obj) ->
		self = @
		# rerender = false
		
		# Handle new company
		if obj.get("company") && !@contacts.get(obj.get("company"))
			@contacts.add(obj.get("company"))
			# rerender = true
		
		if obj.get("company_key") == ''
			@contacts.get(obj).set("company", null)
		
		index = @contacts.indexOf(obj)
		@contacts.sort()
		@view.collection = @contacts
		
		if @search.val() == ''
			self.vent.trigger("contacts:updated", obj)
		else
			@handleSearch()
		
		# if index != @contacts.indexOf(obj)
		# 			rerender = true
		# 		if rerender
		# 			@render()
		# 			view = _.find(@_contactViews, (view) -> view.model == obj)
		# 			view.highlight()
		# 			
		# 		@handleHeadings()
	
	contactAdded: (obj)->
		self = @
		# Handle new company
		if obj.get("company") && !@contacts.get(obj.get("company"))
			@contacts.add(obj.get("company"))
		
		@contacts.add(obj)
		@contacts.sort()
		@view.collection = @contacts
		
		# index = @collection.indexOf(obj)
		# 		@render()
		# 		view = _.find(@_contactViews, (view) -> view.model == obj)
		# 		view.highlight()
		# 		@handleHeadings()
		# 		
		# 		
		# @handleSearch()
		# 
		if @search.val() == ''
			self.vent.trigger("contacts:save_new_successful", obj)
		else
			@handleSearch()
		
		
		@contactView = new Quota.Views.IndexContact({model: obj, vent: @vent})
		@contactView.render()
		@contactView.handleEdit()