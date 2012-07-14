class Quota.Views.EditContactEmails extends Backbone.View

	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_emailViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('contact_emails:check_empty', @checkEmpty, @)
		
	render: ->
		$(@el).empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		frag.appendChild(@addEmpty(new Quota.Models.ContactEmail({name:'', val:''})).render().el)
		$(@el).append(frag)
		@
	
	addOne: (item)->
		view = new Quota.Views.EditContactEmail({model: item, tagName:'li', className:'contact_method contact_email', contact: @model, vent: @vent})
		@_emailViews.push(view)
		view
		
	addEmpty: (item)->
		@collection.add(item)
		view = new Quota.Views.EditContactEmail({model: item, tagName:'li', className:'contact_method contact_email', contact: @model, vent: @vent, hideRemove: true})
		@_emailViews.push(view)
		view
		
	checkEmpty: ->
		if !_.find(@collection.models, (m) -> m.isNew())
			$(@el).append(@addEmpty(new Quota.Models.ContactEmail({name:'', val:''})).render().el)
	
	collectionReset: ->
		@render()
		
	removeFailed: (evt) ->
		view = _.find(@_emailViews, (view) -> view.model == evt.model)
		view.toggle()
		
	removeSuccess: (evt) ->
		# console.log "got here"