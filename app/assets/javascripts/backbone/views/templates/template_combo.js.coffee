class Quota.Views.TemplateComboView extends Backbone.View
	# tagName: 'span'
	# template: HandlebarsTemplates['catalog_items/manufacturer_combo'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"blur input": "selected"
	
	initialize: (options) ->
		self = @
		_.bindAll(@)
		@vent = options.vent if options.vent?
		@parent_model = options.parent_model if options.parent_model?
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
			# source: @collection.pluck @source
			# source: @doCatalogSearch
			source: (typeahead, query) -> 
				$.ajax(
					{
						url: '/api/templates/filter_by_name_or_item'
						data: {filter: query}
						dataType: 'json'
						success: (data) ->
							typeahead.process(data)
					}
				)
			onselect: (obj) -> self.selected(obj)
			strings: false
			minLength: 2
			property: "name"
			sorter: (items) ->
				that = this
				# if !this.strings
				# 					if _.indexOf(_.map(items, (item) -> item[that.property] = item[that.property].toLowerCase()), this.query.toLowerCase())
				# 						i = new Quota.Models.Template(name: this.query)
				# 						items.unshift(i.toJSON())
				# 				else
				# 					if _.indexOf(_.map(items, (item) -> item.toLowerCase()), this.query.toLowerCase())
				# 						items.unshift(this.query)
				items
			matcher: (item) ->
				# if (!this.strings)
				# 					~item[this.property].toLowerCase().indexOf(this.query.toLowerCase())
				# 				else
				# 					~item.toLowerCase().indexOf(this.query.toLowerCase())
				true
			
		$(@el).typeahead options
		
		# catalog_item = _.find(self.collection.models, (m) -> m.get("pub_key") == self.parent_model.get("pub_key"))
		# 		if catalog_item
		# 			# $(@el).attr('value', (catalog_item.get("pn") + ' ' + catalog_item.get("name")))
		# 			$(@el).attr('value', (catalog_item.get("pn") + ' ' + catalog_item.get("name")))
		@
	
	selected: (obj) ->
		# console.log obj
		@trigger('template_combo:item_selected', {template:obj})
		@vent.trigger("template_combo:item_selected", {template:obj})
