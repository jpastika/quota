class Quota.Views.EditContactPhones extends Backbone.View

	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_phoneViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('contact_phones:check_empty', @checkEmpty, @)
		
	render: ->
		$(@el).empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		frag.appendChild(@addEmpty(new Quota.Models.ContactPhone({name:'', val:''})).render().el)
		$(@el).append(frag)
		@
	
	addOne: (item)->
		view = new Quota.Views.EditContactPhone({model: item, tagName:'li', className:'contact_method contact_phone', contact: @model, vent: @vent})
		@_phoneViews.push(view)
		view
		
	addEmpty: (item)->
		@collection.add(item)
		view = new Quota.Views.EditContactPhone({model: item, tagName:'li', className:'contact_method contact_phone', contact: @model, vent: @vent, hideRemove: true})
		@_phoneViews.push(view)
		view
		
	checkEmpty: ->
		if !_.find(@collection.models, (m) -> m.isNew())
			$(@el).append(@addEmpty(new Quota.Models.ContactPhone({name:'', val:''})).render().el)
	
	collectionReset: ->
		@render()
		
	removeFailed: (evt) ->
		view = _.find(@_phoneViews, (view) -> view.model == evt.model)
		view.toggle()
		
	removeSuccess: (evt) ->
		# console.log "got here"