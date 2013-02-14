class Quota.Views.ContactComboView extends Backbone.View
	tagName: 'span'
	template: HandlebarsTemplates['contacts/contact_combo'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"blur input": "selected"
	
	initialize: (options) ->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@source = options.source if options.source?
		@val = options.val if options.val?
		@company_key = options.company_key if options.company_key?
		@className = options.className if options.className?
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
		$(@el).html(@template({className: @className}))
		
		
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
		@$('input').typeahead options
		
		contact = _.find(self.collection.models, (m) -> m.get("pub_key") == self.parent_model.get("contact_key"))
		if contact
			@$('input').attr('value', contact.get("name"))
		@
		
	selected: (obj) ->
		@trigger('contact_name:changed', {contact_name:obj})
		@vent.trigger("contact_name:changed", {contact_name:obj})
		# if obj.originalEvent and obj.originalEvent.explicitOriginalTarget and obj.originalEvent.explicitOriginalTarget.tagName != 'INPUT'
		# 			obj.stopImmediatePropagation()
		# 			obj.preventDefault()
		# 			@vent.trigger('contact_name:changed',{contact_name: $(obj.target).val()})
		# 		else
		# 			contact = _.find(@collection.models, (m) -> m.get("name") == obj)
		# 			if contact || !$(obj.target).val()
		# 				@vent.trigger('contact_name:changed',{contact_name: obj})
		# 			else
		# 				@vent.trigger('contact_name:changed',{contact_name: $(obj.target).val()})