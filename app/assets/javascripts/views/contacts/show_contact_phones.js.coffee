class Quota.Views.ShowContactPhones extends Backbone.View

	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_phoneViews = []
		@collection.on('reset', @collectionReset, @)
		
	render: ->
		$(@el).empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		$(@el).append(frag)
		@
	
	addOne: (item)->
		view = new Quota.Views.ShowContactPhone({model: item, tagName:'li', className:'contact_method contact_phone', contact: @model, vent: @vent})
		@_phoneViews.push(view)
		view
		
	collectionReset: ->
		@render()