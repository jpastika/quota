class Quota.Views.IndexTemplatesListTemplates extends Backbone.View

	# tagName: 'ul'
	# 	className: 'unstyled form-vertical'
	
	# events:
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		# @contact_types = options.contact_types
		@_templateViews = []
		@collection.on('reset', @collectionReset, @)
		@collection.on('destroy:error', @removeFailed, @)
		@collection.on('destroy:success', @removeSuccess, @)
		@vent.on("template:clicked", @templateClicked, @)
		
	render: ->
		$('#templates ul').empty()
		@_templateViews = []
		@addOne(item) for item in @collection.models
		
		@list_headings = $('#templates .section-heading')
		@handleHeadings()
		
		@

	addOne: (item)->
		view = new Quota.Views.IndexTemplatesListTemplate({model: item, tagName:'li', className:'template', template: @model, vent: @vent})
		@_templateViews.push(view)
		# view
		
		frag = document.createDocumentFragment()
		frag.appendChild(view.render().el)
		
		$("#my_list ul").append(frag)
		# if /[^a-z]/i.test(item.get("name").charAt(0).toUpperCase())
		# 			$("#1_list ul").append(frag)
		# 		else
		# 			$("##{item.get("name").charAt(0).toLowerCase()}_list ul").append(frag)
	
	handleHeadings: ->
		if @collection.length > 0
			@showHeadings()
		else
			@hideHeadings()
	
	showHeadings: ->
		@list_headings.show()
		
	hideHeadings: ->
		@list_headings.hide()
	
	collectionReset: ->
		@render()

	templateClicked: (evt) ->
		$('.row_selected').removeClass('row_selected')
		evt.view.highlight()