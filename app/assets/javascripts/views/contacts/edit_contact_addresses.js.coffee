class Quota.Views.EditContactAddresses extends Backbone.View

	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_addressViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on('contact_addresses:check_empty', @checkEmpty, @)
		
	render: ->
		$(@el).empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		frag.appendChild(@addEmpty(new Quota.Models.ContactAddress({name:'', val:''})).render().el)
		$(@el).append(frag)
		@
	
	addOne: (item)->
		view = new Quota.Views.EditContactAddress({model: item, tagName:'li', className:'contact_method contact_address', contact: @model, vent: @vent})
		@_addressViews.push(view)
		view
		
	addEmpty: (item)->
		@collection.add(item)
		view = new Quota.Views.EditContactAddress({model: item, tagName:'li', className:'contact_method contact_address', contact: @model, vent: @vent, hideRemove: true})
		@_addressViews.push(view)
		view
		
	checkEmpty: ->
		if !_.find(@collection.models, (m) -> m.isNew())
			$(@el).append(@addEmpty(new Quota.Models.ContactAddress({name:'', street1:'', city:'', state:'', zip:'', country:''})).render().el)
	
	collectionReset: ->
		@render()
		
	removeFailed: (evt) ->
		view = _.find(@_addressViews, (view) -> view.model == evt.model)
		view.toggle()
		
	removeSuccess: (evt) ->
		# console.log "got here"