class Quota.Views.EditContactPhones extends Backbone.View

	# template: HandlebarsTemplates['contacts/edit_contact_phones'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# 
	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_phoneViews = []
		@collection.on('reset', @handle_collection_reset, @)
		@collection.on('destroy:error', @remove_failed, @)
		@collection.on('destroy:success', @remove_success, @)
		options.vent.on('contact_method_phone_empty:not_empty', @empty_not_empty, @)
		options.vent.on('contact_method_phone_empty:empty', @empty_empty, @)
		
	render: ->
		$(@el).empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(phone).render().el) for phone in @collection.models
		frag.appendChild(@addEmpty(new Quota.Models.ContactPhone({name:'', val:''})).render().el)
		$(@el).append(frag)
		@
	
	addOne: (phone)->
		view = new Quota.Views.EditableContactPhone({model: phone, tagName:'li', className:'contact_method contact_phone', vent: vent})
		@_phoneViews.push(view)
		view
		
	addEmpty: (phone)->
		view = new Quota.Views.EditableContactPhoneEmpty({model: phone, tagName:'li', className:'contact_method contact_phone no_remove', vent: vent})
		@_phoneViews.push(view)
		# _.last(@_phoneViews).on('val:not_empty', $(@el).append(@addEmpty(new Quota.Models.ContactPhone({name:'', val:''})).render().el))
		# 		_.last(@_phoneViews).on('val:empty', if view != _.last(@_phoneViews) then _.last(@_phoneViews).remove())
		view
	
	handle_collection_reset: ->
		@render()
		
	setup_empty: ->
		@collection.reset([{name:'', val:''}])
	
	remove_failed: (evt) ->
		view = _.find(@_phoneViews, (view) -> view.model == evt.model)
		view.toggle()
		
	remove_success: (evt) ->
		console.log "got here"
		
	empty_not_empty: (evt) ->
		console.log "empty is not empty"
		
	empty_empty: (evt) ->
		console.log "empty is empty"