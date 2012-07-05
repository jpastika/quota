class Quota.Views.EditContactPhones extends Backbone.View

	# template: HandlebarsTemplates['contacts/edit_contact_phones'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# 
	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_phoneViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		options.vent.on('contact_method_phone_empty:not_empty', @emptyNotEmpty, @)
		options.vent.on('contact_method_phone_empty:empty', @emptyEmpty, @)
		
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
	
	collectionReset: ->
		@render()
		
	# setupEmpty: ->
	# 		@collection.reset([{name:'', val:''}])
	
	removeFailed: (evt) ->
		view = _.find(@_phoneViews, (view) -> view.model == evt.model)
		view.toggle()
		
	removeSuccess: (evt) ->
		console.log "got here"
		
	emptyNotEmpty: (evt) ->
		console.log "empty is not empty"
		
	emptyEmpty: (evt) ->
		console.log "empty is empty"