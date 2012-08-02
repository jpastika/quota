class Quota.Views.CompanySelectView extends Backbone.View
	tagName: 'input'
	
	events:
		"blur": "selected"
	
	initialize: (options) ->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@source = options.source if options.source?
		@val = options.val if options.val?
		@

	# Retrieves the Backbone Model that matches this view's value
	# Will have problems if you have multiple Models with the same attribute that
	# you are using as the typeahead's source.
	getModel: () ->
		# value of the input field
		value = @$el.val()
		@collection.find (model) =>
			source = model.get @source
			source is value

	# Render the input and call Bootstrap's .typeahead() plugin
	render: ->
		self = @
		options = _.extend @options, 
			source: @collection.pluck @source
			onselect: (obj) -> self.selected(obj)
			showAdd: true
		@$el.typeahead options
		
		company = _.find(self.collection.models, (m) -> m.get("pub_key") == self.parent_model.get("company_key"))
		if company
			@$el.attr('value', company.get("name"))
		@$el.attr('placeholder', 'Company')
		@
		
	selected: (obj) ->
		if obj.originalEvent and obj.originalEvent.explicitOriginalTarget and obj.originalEvent.explicitOriginalTarget.tagName != 'INPUT'
			obj.stopImmediatePropagation()
			obj.preventDefault()
			@vent.trigger('company_name:changed',{company_name: $(obj.target).val()})
		else
			company = _.find(@collection.models, (m) -> m.get("name") == obj)
			if company || !$(obj.target).val()
				@vent.trigger('company_name:changed',{company_name: obj})
			else
				@vent.trigger('company_name:changed',{company_name: $(obj.target).val()})