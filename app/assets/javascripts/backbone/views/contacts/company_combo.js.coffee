class Quota.Views.CompanyComboView extends Backbone.View
	tagName: 'span'
	template: HandlebarsTemplates['contacts/company_combo'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	# events:
	# 		"blur input": "selected"
	
	initialize: (options) ->
		_.bindAll(@)
		@vent = options.vent
		@parent_model = options.parent_model
		@source = options.source if options.source?
		@val = options.val if options.val?
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
		# options = _.extend @options, 
		# 			source: @collection.pluck @source
		# 			onselect: (obj) -> self.selected(obj)
		# 			sorter: (items) ->
		# 				if _.indexOf(_.map(items, (item) -> item.toLowerCase()), this.query.toLowerCase())
		# 					items.unshift(this.query)
		# 				return items
		# 		@$('input').typeahead options
		
		options = _.extend @options, 
			# source: @collection.pluck @source
			# source: @doCatalogSearch
			source: (typeahead, query) -> 
				$.ajax(
					{
						url: '/api/companies/filter_by_name'
						data: {filter: query}
						dataType: 'json'
						success: (data) ->
							typeahead.process(data)
					}
				)
			onselect: (obj) -> self.selected(obj)
			strings: false
			minLength: 1
			property: "name"
			sorter: (items) ->
				that = this
				if !this.strings
					if _.indexOf(_.map(items, (item) -> item[that.property] = item[that.property].toLowerCase()), this.query.toLowerCase())
						i = new Quota.Models.Contact(name: this.query)
						i.set("is_company", true)
						items.unshift(i.toJSON())
				else
					if _.indexOf(_.map(items, (item) -> item.toLowerCase()), this.query.toLowerCase())
						items.unshift(this.query)
				items
			matcher: (item) ->
				if (!this.strings)
					~item[this.property].toLowerCase().indexOf(this.query.toLowerCase())
				else
					~item.toLowerCase().indexOf(this.query.toLowerCase())
			
		$(@el).typeahead options
		
		# company = _.find(self.collection.models, (m) -> m.get("pub_key") == self.parent_model.get("company_key"))
		# 		if company
		# 			@$('input').attr('value', company.get("name"))
		@
		
	selected: (obj) ->
		@trigger('company_name:changed', {company_name:obj})
		@vent.trigger("company_name:changed", {company_name:obj})
		@trigger('company_combo:item_selected', {company:obj})
		@vent.trigger("company_combo:item_selected", {company:obj})
		# console.log obj
		# 		
		# 		if obj.originalEvent and obj.originalEvent.explicitOriginalTarget and obj.originalEvent.explicitOriginalTarget.tagName != 'INPUT'
		# 			obj.stopImmediatePropagation()
		# 			obj.preventDefault()
		# 			@vent.trigger('company_name:changed',{company_name: $(obj.target).val()})
		# 		else
		# 			company = _.find(@collection.models, (m) -> m.get("name") == obj)
		# 			if company || !$(obj.target).val()
		# 				@vent.trigger('company_name:changed',{company_name: obj})
		# 			else
		# 				@vent.trigger('company_name:changed',{company_name: $(obj.target).val()})