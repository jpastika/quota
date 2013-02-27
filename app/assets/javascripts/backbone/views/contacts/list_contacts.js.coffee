class Quota.Views.ListContacts extends Backbone.View

	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	# events:
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		# @contact_types = options.contact_types
		@_contactViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('contact_link:clicked', @contactLinkClicked, @)
		@vent.on("contact:clicked", @contactClicked, @)
		@vent.on("contact:updated", @contactUpdated)
		@vent.on("contact:save_new_successful", @contactAdded, @)
		
	render: ->
		$('.contacts_list ul').empty()
		@_contactViews = []
		# frag = document.createDocumentFragment()
		# frag.appendChild(@addOne(item).render().el) for item in @collection.models
		# $(@el).append(frag)
		@addOne(item) for item in @collection.models
		@
	
	# addOne: (item)->
	# 		view = new Quota.Views.ListContact({model: item, tagName:'li', className:'contact', contact: @model, vent: @vent})
	# 		@_contactViews.push(view)
	# 		view
		
	addOne: (item)->
		view = new Quota.Views.ListContact({model: item, tagName:'li', className:'contact', contact: @model, vent: @vent})
		@_contactViews.push(view)
		# view
		
		frag = document.createDocumentFragment()
		frag.appendChild(view.render().el)
		
		if /[^a-z]/i.test(item.get("name").charAt(0).toUpperCase())
			$("#1_list ul").append(frag)
		else
			$("##{item.get("name").charAt(0).toLowerCase()}_list ul").append(frag)
	
	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_contactViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
		
	contactClicked: (evt) ->
		$('.row_selected').removeClass('row_selected')
		evt.view.highlight()
		
		# var index = this.collection.indexOf(this.model);
		# 		var modelAbove = this.collection.at(index-1);
		
		# console.log @collection.indexOf(evt.model)
	
	contactUpdated: (obj) ->
		self = @
		rerender = false
		
		# Handle new company
		if obj.get("company") && !@collection.get(obj.get("company"))
			@collection.add(obj.get("company"))
			rerender = true
		
		if obj.get("company_key") == ''
			@collection.get(obj).set("company", null)
		
		index = @collection.indexOf(obj)
		@collection.sort()
		if index != @collection.indexOf(obj)
			rerender = true
		if rerender
			@render()
			view = _.find(@_contactViews, (view) -> view.model == obj)
			view.highlight()
		# view = _.find(@_contactViews, (view) -> view.model == obj)
		# 		index = @collection.indexOf(obj)
		# 		prev_view = _.find(@_contactViews, (view) -> view.model == self.collection.at(index-1))
		# 		new_view = view
		# 		# view.remove()
		# 		prev_view.$el.after(new_view)
		# 		# console.log prev_view.model
		# 		# @render()
		
	contactAdded: (obj) ->
		self = @
		# Handle new company
		if obj.get("company") && !@collection.get(obj.get("company"))
			@collection.add(obj.get("company"))
		
		@collection.add(obj)
		@collection.sort()
		index = @collection.indexOf(obj)
		@render()
		view = _.find(@_contactViews, (view) -> view.model == obj)
		view.highlight()
	
	contactLinkClicked: (evt) ->
		# console.log evt.view.model.get("name")
	# 		@setContactTypeRelatedFields()