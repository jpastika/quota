class Quota.Views.EditContactUrlsList extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# el: '#contact_urls_container .section-table tbody'
	el: '.contact_urls ul'
	
	# events:
	# 		"click .contact_remove": "destroy"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_urlViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@contact = options.parent_model
		
		@vent.on('contact_urls:add_new_url_successful', @addNewUrl_Success, @)
		
	render: ->
		# $(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		
		@

	addOne: (item)->
		# view = new Quota.Views.EditContactUrl({model: item, tagName:'tr', contact: @model, vent: @vent, index: (@collection.models.length - 1)})
		view = new Quota.Views.EditContactUrl({model: item, tagName:'li', contact: @model, vent: @vent, index: (@collection.models.length - 1)})
		@_urlViews.push(view)
		view

	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_urlViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
		# console.log "got here"

	# destroy: (evt) ->
	# 		$(@el).toggle()
	# 		# @model.trigger('removing', {view: @})
	# 		@model.remove()

	hideRemove: () ->
		@hideRemove = true
		@$el.find('.url_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		@$el.find('.url_remove').css('visibility', '')
		
	addNewUrl_Success: (obj)->
		model = obj.model
		self = @
		
		self.collection.add(model)
		frag = document.createDocumentFragment()
		frag.appendChild(self.addOne(model).render().el)
		self.$el.append(frag)

	handleError: (attribute, message) ->
		console.log message