class Quota.Views.ManufacturerComboView extends Backbone.View
	# tagName: 'span'
	# template: HandlebarsTemplates['catalog_items/manufacturer_combo'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"blur": "selected"
	
	initialize: (options) ->
		self = @
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
		# $(@el).html(@template({company:@collection.toJSON(), field_name:@field_name}))
		self = @
		# $(@el).html(@template())

		# @$el.attr('value', company.get("name"))
		# @$el.attr('placeholder', 'Company')
		# 
		options = _.extend @options, 
			source: @collection.pluck @source
			onselect: (obj) -> self.selected(obj)
			sorter: (items) ->
				if _.indexOf(_.map(items, (item) -> item.toLowerCase()), this.query.toLowerCase())
					items.unshift(this.query)
				return items
		$(@el).typeahead options
		
		manufacturer = _.find(self.collection.models, (m) -> m.get("name") == self.parent_model.get("name"))
		if manufacturer
			$(@el).attr('value', manufacturer.get("name"))
		@
		
	selected: (obj) ->
		if obj.originalEvent and obj.originalEvent.explicitOriginalTarget and obj.originalEvent.explicitOriginalTarget.tagName != 'INPUT'
			obj.stopImmediatePropagation()
			obj.preventDefault()
			@vent.trigger('manufacturer_name:changed',{manufacturer_name: $(obj.target).val()})
		else
			manufacturer = _.find(@collection.models, (m) -> m.get("name") == obj)
			if manufacturer || !$(obj.target).val()
				@vent.trigger('manufacturer_name:changed',{manufacturer_name: obj})
			else
				@vent.trigger('manufacturer_name:changed',{manufacturer_name: $(obj.target).val()})