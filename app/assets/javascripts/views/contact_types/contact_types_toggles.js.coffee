class Quota.Views.ContactTypesToggles extends Backbone.View

	# template: HandlebarsTemplates['contacts/edit_contact_phones'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# 
	tagName: 'div'
	className: ''
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@contact = options.contact
		@_contactTypeViews = []
		@collection.on('reset', @handle_collection_reset, @)
		@vent.on('contact_types:reset', @render, @)
		
		
	render: ->
		$(@el).empty()
		frag = document.createDocumentFragment()
		frag.appendChild(@addOne(contact_type).render().el) for contact_type in @collection.models
		$(@el).append(frag)
		if @_contactTypeViews.length
			@set_selected()
		@
	
	addOne: (contact_type)->
		view = new Quota.Views.ContactTypesToggle({model: contact_type, tagName:'span', className:'contact_type', vent: @vent})
		@_contactTypeViews.push(view)
		view
		
	set_selected: ()->
		self = @
		if @contact && @contact.get('contact_type_key')
			view = _.find self._contactTypeViews, (vw) -> vw.model.get('pub_key') == self.contact.get('contact_type_key')
		else
			view = _.find self._contactTypeViews, (vw) -> vw.model.get('is_default') == true
		view.select()
			
	get_selected: ->
		self = @
		view = _.find self._contactTypeViews, (vw) -> vw.model.get('pub_key') == $('#contact_types input:radio:checked').attr('value')
		
	handle_collection_reset: ->
		@render()