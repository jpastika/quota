class Quota.Views.IndexContactPhonesList extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts_list'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# el: '#contact_phones_container .section-table tbody'
	el: '.contact_phones .contact_phones_list'
	
	# events:
	# 		"click .contact_remove": "destroy"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@_phoneViews = []
		# @collection.on('reset', @collectionReset, @)
		# 		@collection.on('destroy:error', @removeFailed, @)
		# 		@collection.on('destroy:success', @removeSuccess, @)
		@contact = options.parent_model
		
		@vent.on('contact_phones:save_new_contact_phone_successful', @addNewPhone_Success, @)
		
	render: ->
		# $(@el).html(@template({}))
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(item).render().el) for item in @collection.models
		@$el.append(frag)
		
		@

	addOne: (item)->
		# view = new Quota.Views.EditContactPhone({model: item, tagName:'tr', contact: @model, vent: @vent, index: (@collection.models.length - 1)})
		view = new Quota.Views.IndexContactPhone({model: item, tagName:'li', contact: @model, vent: @vent, index: (@collection.models.length - 1)})
		@_phoneViews.push(view)
		view
		
	collectionReset: ->
		@render()

	removeFailed: (evt) ->
		view = _.find(@_phoneViews, (view) -> view.model == evt.model)
		view.toggle()

	removeSuccess: (evt) ->
		# console.log "got here"

	# destroy: (evt) ->
	# 		$(@el).toggle()
	# 		# @model.trigger('removing', {view: @})
	# 		@model.remove()

	hideRemove: () ->
		@hideRemove = true
		@$el.find('.phone_remove').css('visibility', 'hidden')

	showRemove: () ->
		@hideRemove = false
		@$el.find('.phone_remove').css('visibility', '')
		
	addNewPhone_Success: (obj)->
		model = obj.model
		self = @
		
		# self.collection.add(model)
		view = self.addOne(model)
		frag = document.createDocumentFragment()
		frag.appendChild(view.render().el)
		self.$el.append(frag)
		
		view.handleEdit()

	handleError: (attribute, message) ->
		console.log message