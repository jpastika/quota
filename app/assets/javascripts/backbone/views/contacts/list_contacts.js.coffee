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
		@contact_types = options.contact_types
		@_contactViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('contact_link:clicked', @contactLinkClicked, @)
		
	render: ->
		# $(@el).empty()
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
		view = new Quota.Views.ListContact({model: item, tagName:'li', className:'contact', contact: @model, contact_types: @contact_types, vent: @vent})
		@_contactViews.push(view)
		# view
		
		frag = document.createDocumentFragment()
		frag.appendChild(view.render().el)
		
		if /[^a-z]/i.test(item.get("name").charAt(0).toUpperCase())
			$("a[name=1]").parent().next().find("ul").append(frag)
		else
			$("a[name=#{item.get("name").charAt(0).toUpperCase()}]").parent().next().find("ul").first().append(frag)
	
	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_contactViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
	
	contactLinkClicked: (evt) ->
		# console.log evt.view.model.get("name")
	# 		@setContactTypeRelatedFields()